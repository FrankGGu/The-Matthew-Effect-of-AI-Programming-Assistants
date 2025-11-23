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
        Arrays.sort(indexedTasks, (a, b) -> a[0] - b[0]);
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] == b[1] ? a[2] - b[2] : a[1] - b[1]);
        int[] res = new int[n];
        int time = 0;
        int i = 0;
        int idx = 0;
        while (i < n) {
            while (i < n && indexedTasks[i][0] <= time) {
                pq.offer(new int[]{indexedTasks[i][0], indexedTasks[i][1], indexedTasks[i][2]});
                i++;
            }
            if (pq.isEmpty()) {
                time = indexedTasks[i][0];
                continue;
            }
            int[] curr = pq.poll();
            res[idx++] = curr[2];
            time += curr[1];
        }
        while (!pq.isEmpty()) {
            res[idx++] = pq.poll()[2];
        }
        return res;
    }
}