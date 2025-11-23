public class Solution {

import java.util.*;

public class Solution {
    public int[] assignTasks(int[] servers, int[] tasks) {
        PriorityQueue<int[]> freeServers = new PriorityQueue<>((a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);
        for (int i = 0; i < servers.length; i++) {
            freeServers.add(new int[]{servers[i], i});
        }

        PriorityQueue<int[]> busyServers = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        int[] result = new int[tasks.length];
        int time = 0;
        int taskIndex = 0;

        while (taskIndex < tasks.length) {
            if (busyServers.isEmpty() || busyServers.peek()[0] > time) {
                time = Math.max(time, taskIndex);
                while (taskIndex <= time && taskIndex < tasks.length) {
                    int[] server = freeServers.poll();
                    if (server == null) {
                        break;
                    }
                    result[taskIndex] = server[1];
                    busyServers.add(new int[]{time + tasks[taskIndex], server[1]});
                    taskIndex++;
                }
            } else {
                int[] server = busyServers.poll();
                result[server[1]] = server[1];
                freeServers.add(new int[]{server[0], server[1]});
                time = server[0];
            }
        }

        return result;
    }
}
}