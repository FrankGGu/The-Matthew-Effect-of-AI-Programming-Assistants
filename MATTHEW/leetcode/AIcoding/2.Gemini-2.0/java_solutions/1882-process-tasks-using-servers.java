import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] assignTasks(int[] servers, int[] tasks) {
        int n = servers.length;
        int m = tasks.length;
        int[] res = new int[m];

        PriorityQueue<int[]> available = new PriorityQueue<>((a, b) -> (a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]));
        for (int i = 0; i < n; i++) {
            available.offer(new int[]{servers[i], i});
        }

        PriorityQueue<int[]> busy = new PriorityQueue<>((a, b) -> (a[0] - b[0]));

        int time = 0;
        for (int i = 0; i < m; i++) {
            time = Math.max(time, i);

            while (!busy.isEmpty() && busy.peek()[0] <= time) {
                int[] server = busy.poll();
                available.offer(new int[]{servers[server[1]], server[1]});
            }

            if (available.isEmpty()) {
                time = busy.peek()[0];
                while (!busy.isEmpty() && busy.peek()[0] <= time) {
                    int[] server = busy.poll();
                    available.offer(new int[]{servers[server[1]], server[1]});
                }
            }

            int[] server = available.poll();
            res[i] = server[1];
            busy.offer(new int[]{time + tasks[i], server[1]});
            time++;
        }

        return res;
    }
}