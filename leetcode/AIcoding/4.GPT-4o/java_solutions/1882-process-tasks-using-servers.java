import java.util.*;

class Solution {
    public int[] assignTasks(int[] servers, int[] tasks) {
        int n = servers.length, m = tasks.length;
        int[] result = new int[m];
        PriorityQueue<int[]> freeServers = new PriorityQueue<>((a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
        PriorityQueue<int[]> busyServers = new PriorityQueue<>((a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);

        for (int i = 0; i < n; i++) {
            freeServers.offer(new int[]{0, i});
        }

        for (int time = 0; time < m; time++) {
            while (!busyServers.isEmpty() && busyServers.peek()[0] <= time) {
                freeServers.offer(new int[]{0, busyServers.poll()[1]});
            }
            if (freeServers.isEmpty()) {
                time = busyServers.peek()[0];
            }
            int[] server = freeServers.poll();
            result[time] = server[1];
            busyServers.offer(new int[]{time + tasks[time], server[1]});
        }

        return result;
    }
}