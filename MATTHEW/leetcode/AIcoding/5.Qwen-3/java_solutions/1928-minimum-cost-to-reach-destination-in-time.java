public class Solution {

import java.util.*;

public class Solution {
    public int minCostToReachDestination(int n, int[][] roads, int k) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            int u = road[0], v = road[1], cost = road[2];
            graph.get(u).add(new int[]{v, cost});
            graph.get(v).add(new int[]{u, cost});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, 0});
        int[] time = new int[n];
        Arrays.fill(time, Integer.MAX_VALUE);
        time[0] = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int cost = curr[0], node = curr[1];
            if (node == n - 1) {
                return cost;
            }
            for (int[] next : graph.get(node)) {
                int nextNode = next[0], nextCost = next[1];
                if (time[nextNode] > time[node] + 1) {
                    time[nextNode] = time[node] + 1;
                    pq.offer(new int[]{cost + nextCost, nextNode});
                } else if (time[nextNode] == time[node] + 1 && cost + nextCost < pq.peek()[0]) {
                    pq.offer(new int[]{cost + nextCost, nextNode});
                }
            }
        }
        return -1;
    }
}
}