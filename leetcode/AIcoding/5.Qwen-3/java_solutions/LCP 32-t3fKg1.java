public class Solution {

import java.util.*;

public class Solution {
    public int[] getResults(int[][] tasks) {
        Arrays.sort(tasks, (a, b) -> a[0] - b[0]);
        int n = tasks.length;
        int[] results = new int[n];
        int time = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        int i = 0;
        while (i < n || !pq.isEmpty()) {
            if (i < n && tasks[i][0] <= time) {
                pq.add(tasks[i]);
                i++;
                continue;
            }
            if (pq.isEmpty()) {
                time = tasks[i][0];
            } else {
                int[] task = pq.poll();
                results[task[2]] = time + task[1];
                time += task[1];
            }
        }
        return results;
    }
}
}