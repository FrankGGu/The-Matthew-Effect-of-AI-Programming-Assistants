import java.util.PriorityQueue;

public class Solution {
    public int minimumTime(int[][] tasks) {
        int n = tasks.length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        int time = 0;
        int i = 0;

        while (i < n || !pq.isEmpty()) {
            if (pq.isEmpty()) {
                time = Math.max(time, tasks[i][0]);
            }

            while (i < n && tasks[i][0] <= time) {
                pq.offer(tasks[i++]);
            }

            if (!pq.isEmpty()) {
                int[] task = pq.poll();
                time += task[1];
            }
        }

        return time;
    }
}