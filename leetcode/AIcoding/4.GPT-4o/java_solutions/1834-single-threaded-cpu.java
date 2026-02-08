import java.util.*;

class Solution {
    public int[] getOrder(int[][] tasks) {
        int n = tasks.length;
        int[][] indexedTasks = new int[n][3];

        for (int i = 0; i < n; i++) {
            indexedTasks[i][0] = tasks[i][0];
            indexedTasks[i][1] = tasks[i][1];
            indexedTasks[i][2] = i;
        }

        Arrays.sort(indexedTasks, Comparator.comparingInt(a -> a[0]));

        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> a[1] == b[1] ? a[2] - b[2] : a[1] - b[1]);

        int[] result = new int[n];
        int index = 0, time = 0, i = 0;

        while (index < n) {
            while (i < n && indexedTasks[i][0] <= time) {
                minHeap.offer(indexedTasks[i]);
                i++;
            }

            if (minHeap.isEmpty()) {
                time = indexedTasks[i][0];
            } else {
                int[] task = minHeap.poll();
                result[index++] = task[2];
                time += task[1];
            }
        }

        return result;
    }
}