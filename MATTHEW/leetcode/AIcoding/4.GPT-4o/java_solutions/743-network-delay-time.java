import java.util.*;

public class Solution {
    public int networkDelayTime(int[][] times, int N, int K) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] time : times) {
            graph.putIfAbsent(time[0], new ArrayList<>());
            graph.get(time[0]).add(new int[]{time[1], time[2]});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{K, 0});
        Map<Integer, Integer> dist = new HashMap<>();

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0], time = curr[1];
            if (dist.containsKey(node)) continue;
            dist.put(node, time);
            for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                int nextNode = neighbor[0], travelTime = neighbor[1];
                if (!dist.containsKey(nextNode)) {
                    pq.offer(new int[]{nextNode, time + travelTime});
                }
            }
        }

        if (dist.size() < N) return -1;
        return Collections.max(dist.values());
    }
}