public class Solution {

import java.util.*;

public class Solution {
    public int networkDelayTime(int[][] times, int n, int k) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] time : times) {
            graph.putIfAbsent(time[0], new ArrayList<>());
            graph.get(time[0]).add(new int[]{time[1], time[2]});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{k, 0});

        Set<Integer> visited = new HashSet<>();
        int maxTime = 0;

        while (!pq.isEmpty()) {
            int[] node = pq.poll();
            int nodeID = node[0];
            int time = node[1];

            if (visited.contains(nodeID)) continue;

            visited.add(nodeID);
            maxTime = Math.max(maxTime, time);

            if (graph.containsKey(nodeID)) {
                for (int[] neighbor : graph.get(nodeID)) {
                    pq.offer(new int[]{neighbor[0], time + neighbor[1]});
                }
            }
        }

        return visited.size() == n ? maxTime : -1;
    }
}
}