public class Solution {

import java.util.*;

public class Solution {
    public int[][] getMinCost(int[][] rides, int n) {
        List<int[]>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] ride : rides) {
            int from = ride[0];
            int to = ride[1];
            int cost = ride[2];
            graph[from].add(new int[]{to, cost});
        }

        int[][] minCost = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(minCost[i], Integer.MAX_VALUE);
        }

        for (int start = 0; start < n; start++) {
            PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
            pq.offer(new int[]{start, 0});
            boolean[] visited = new boolean[n];
            while (!pq.isEmpty()) {
                int[] node = pq.poll();
                int current = node[0];
                int cost = node[1];
                if (visited[current]) continue;
                visited[current] = true;
                minCost[start][current] = cost;
                for (int[] neighbor : graph[current]) {
                    int nextNode = neighbor[0];
                    int nextCost = neighbor[1];
                    if (!visited[nextNode] && cost + nextCost < minCost[start][nextNode]) {
                        pq.offer(new int[]{nextNode, cost + nextCost});
                    }
                }
            }
        }

        return minCost;
    }
}
}