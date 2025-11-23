public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> busiestServers(int[] requests, int[] weights) {
        int n = requests.length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        TreeSet<Integer> availableServers = new TreeSet<>();
        for (int i = 0; i < n; i++) {
            availableServers.add(i);
        }

        for (int i = 0; i < n; i++) {
            int time = requests[i];
            int weight = weights[i];

            while (!pq.isEmpty() && pq.peek()[0] <= time) {
                int[] server = pq.poll();
                availableServers.add(server[1]);
            }

            if (availableServers.isEmpty()) {
                continue;
            }

            Integer serverId = availableServers.ceiling(i % n);
            if (serverId == null) {
                serverId = availableServers.first();
            }

            pq.offer(new int[]{time + weight, serverId});
            availableServers.remove(serverId);
        }

        Map<Integer, Integer> countMap = new HashMap<>();
        while (!pq.isEmpty()) {
            int[] server = pq.poll();
            countMap.put(server[1], countMap.getOrDefault(server[1], 0) + 1);
        }

        int maxRequests = 0;
        for (int count : countMap.values()) {
            maxRequests = Math.max(maxRequests, count);
        }

        List<Integer> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            if (entry.getValue() == maxRequests) {
                result.add(entry.getKey());
            }
        }

        Collections.sort(result);
        return result;
    }
}
}