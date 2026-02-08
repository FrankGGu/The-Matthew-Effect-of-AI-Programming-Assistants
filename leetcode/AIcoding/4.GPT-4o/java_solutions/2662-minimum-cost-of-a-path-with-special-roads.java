import java.util.*;

class Solution {
    public int minimumCost(int[][] start, int[][] target, int[][] specialRoads) {
        int n = specialRoads.length;
        int[][] graph = new int[n + 2][n + 2];
        for (int[] row : graph) Arrays.fill(row, Integer.MAX_VALUE);

        for (int i = 0; i < n + 2; i++) {
            graph[i][i] = 0;
        }

        graph[0][1] = Math.abs(start[0] - target[0]) + Math.abs(start[1] - target[1]);
        graph[1][0] = graph[0][1];

        for (int i = 0; i < n; i++) {
            int[] road = specialRoads[i];
            graph[0][i + 2] = Math.abs(start[0] - road[0]) + Math.abs(start[1] - road[1]) + road[2];
            graph[i + 2][0] = graph[0][i + 2];
            graph[1][i + 2] = Math.abs(target[0] - road[0]) + Math.abs(target[1] - road[1]) + road[2];
            graph[i + 2][1] = graph[1][i + 2];
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    int[] nextRoad = specialRoads[j];
                    graph[i + 2][j + 2] = Math.abs(road[0] - nextRoad[0]) + Math.abs(road[1] - nextRoad[1]) + nextRoad[2];
                    graph[j + 2][i + 2] = graph[i + 2][j + 2];
                }
            }
        }

        return dijkstra(graph, n + 2);
    }

    private int dijkstra(int[][] graph, int n) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int d = curr[0], u = curr[1];
            if (d > dist[u]) continue;
            for (int v = 0; v < n; v++) {
                if (graph[u][v] != Integer.MAX_VALUE) {
                    int newDist = d + graph[u][v];
                    if (newDist < dist[v]) {
                        dist[v] = newDist;
                        pq.offer(new int[]{newDist, v});
                    }
                }
            }
        }

        return dist[1] == Integer.MAX_VALUE ? -1 : dist[1];
    }
}