class Solution {
    public int[] assignTasks(int[] servers, int[] tasks) {
        int n = servers.length;
        int m = tasks.length;
        int[] res = new int[m];

        PriorityQueue<int[]> freeServers = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });

        PriorityQueue<int[]> usedServers = new PriorityQueue<>((a, b) -> {
            if (a[2] != b[2]) return a[2] - b[2];
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });

        for (int i = 0; i < n; i++) {
            freeServers.offer(new int[]{servers[i], i, 0});
        }

        for (int time = 0; time < m; time++) {
            while (!usedServers.isEmpty() && usedServers.peek()[2] <= time) {
                int[] server = usedServers.poll();
                freeServers.offer(new int[]{server[0], server[1], server[2]});
            }

            if (freeServers.isEmpty()) {
                int[] server = usedServers.poll();
                res[time] = server[1];
                server[2] += tasks[time];
                usedServers.offer(server);
            } else {
                int[] server = freeServers.poll();
                res[time] = server[1];
                server[2] = time + tasks[time];
                usedServers.offer(server);
            }
        }

        return res;
    }
}