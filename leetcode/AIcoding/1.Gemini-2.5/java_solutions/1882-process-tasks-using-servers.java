import java.util.PriorityQueue;

class Solution {
    public int[] assignTasks(int[] servers, int[] tasks) {
        // availableServers stores {weight, index}
        // Sorted by weight (ascending), then index (ascending)
        PriorityQueue<int[]> availableServers = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });

        // busyServers stores {finishTime, weight, index}
        // Sorted by finishTime (ascending), then weight (ascending), then index (ascending)
        PriorityQueue<long[]> busyServers = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return Long.compare(a[0], b[0]);
            }
            if (a[1] != b[1]) {
                return Long.compare(a[1], b[1]);
            }
            return Long.compare(a[2], b[2]);
        });

        // Initialize availableServers with all servers
        for (int i = 0; i < servers.length; i++) {
            availableServers.offer(new int[]{servers[i], i});
        }

        int[] result = new int[tasks.length];
        long currentTime = 0; // Represents the current simulation time

        for (int i = 0; i < tasks.length; i++) {
            // Task 'i' arrives at time 'i'.
            // Advance simulation time to at least the current task's arrival time.
            currentTime = Math.max(currentTime, (long) i);

            // Move servers from busy to available if their finishTime is less than or equal to currentTime
            while (!busyServers.isEmpty() && busyServers.peek()[0] <= currentTime) {
                long[] server = busyServers.poll();
                availableServers.offer(new int[]{(int) server[1], (int) server[2]}); // {weight, index}
            }

            // If no servers are available, we must wait for the earliest busy server to free up.
            if (availableServers.isEmpty()) {
                long[] server = busyServers.poll();
                currentTime = server[0]; // Advance currentTime to when this server becomes free
                availableServers.offer(new int[]{(int) server[1], (int) server[2]}); // {weight, index}

                // After advancing time, other servers might also become free at this new currentTime.
                // Release them as well.
                while (!busyServers.isEmpty() && busyServers.peek()[0] <= currentTime) {
                    long[] s = busyServers.poll();
                    availableServers.offer(new int[]{(int) s[1], (int) s[2]});
                }
            }

            // Now, availableServers is guaranteed to be not empty.
            // Assign the current task 'i' to the best available server.
            int[] assignedServer = availableServers.poll();
            int serverIndex = assignedServer[1];
            long finishTime = currentTime + tasks[i];

            busyServers.offer(new long[]{finishTime, assignedServer[0], assignedServer[1]});
            result[i] = serverIndex;
        }

        return result;
    }
}