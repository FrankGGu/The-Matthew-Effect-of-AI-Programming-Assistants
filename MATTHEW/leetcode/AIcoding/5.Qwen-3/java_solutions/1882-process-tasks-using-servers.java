public class Solution {

import java.util.*;

public class Solution {
    public int[] assignTasks(int[] servers, int[] tasks) {
        int n = servers.length;
        int m = tasks.length;
        int[] result = new int[m];

        PriorityQueue<int[]> freeServers = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });

        for (int i = 0; i < n; i++) {
            freeServers.offer(new int[]{servers[i], i});
        }

        PriorityQueue<int[]> busyServers = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        int time = 0;
        int taskIndex = 0;

        while (taskIndex < m) {
            while (!busyServers.isEmpty() && busyServers.peek()[0] <= time) {
                int[] server = busyServers.poll();
                freeServers.offer(new int[]{server[1], server[2]});
            }

            if (freeServers.isEmpty()) {
                time = busyServers.peek()[0];
            } else {
                int[] server = freeServers.poll();
                int serverWeight = server[0];
                int serverIndex = server[1];
                result[taskIndex] = serverIndex;
                busyServers.offer(new int[]{time + tasks[taskIndex], serverWeight, serverIndex});
                taskIndex++;
            }
        }

        return result;
    }
}
}