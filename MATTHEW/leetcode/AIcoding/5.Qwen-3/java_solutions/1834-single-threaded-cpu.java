public class Solution {

import java.util.*;

public class Solution {
    public int[] getOrder(int[][] tasks) {
        int n = tasks.length;
        int[][] taskArray = new int[n][3];

        for (int i = 0; i < n; i++) {
            taskArray[i][0] = tasks[i][0]; // enqueueTime
            taskArray[i][1] = tasks[i][1]; // processingTime
            taskArray[i][2] = i; // original index
        }

        Arrays.sort(taskArray, (a, b) -> a[0] - b[0]);

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[1] != b[1]) {
                return a[1] - b[1];
            }
            return a[2] - b[2];
        });

        int[] result = new int[n];
        int index = 0;
        long time = 0;
        int i = 0;

        while (i < n || !pq.isEmpty()) {
            if (pq.isEmpty()) {
                time = Math.max(time, taskArray[i][0]);
            }

            while (i < n && taskArray[i][0] <= time) {
                pq.offer(taskArray[i]);
                i++;
            }

            int[] current = pq.poll();
            result[index++] = current[2];
            time += current[1];
        }

        return result;
    }
}
}