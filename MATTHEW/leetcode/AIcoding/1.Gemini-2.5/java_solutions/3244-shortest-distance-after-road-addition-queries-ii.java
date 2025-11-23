import java.util.*;

class Solution {
    public long[] shortestDistanceAfterRoadAdditionQueriesII(int n, int[][] initialEdges, int[][] queries) {
        long[][] dist = new long[n][n];
        long INF = Long.MAX_VALUE / 2; // Use a large enough value for infinity to prevent overflow

        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], INF);
            dist[i][i] = 0;
        }

        for (int[] edge : initialEdges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            dist[u][v] = Math.min(dist[u][v], w);
            dist[v][u] = Math.min(dist[v][u], w);
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][k] != INF && dist[k][j] != INF) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        List<Long> results = new ArrayList<>();

        for (int[] query : queries) {
            int type = query[0];
            if (type == 1) {
                int u = query[1];
                int v = query[2];
                int w = query[3];

                if (dist[u][v] > w) {
                    dist[u][v] = w;
                    dist[v][u] = w;

                    for (int i = 0; i < n; i++) {
                        for (int j = 0; j < n; j++) {
                            if (dist[i][u] != INF && dist[v][j] != INF) {
                                dist[i][j] = Math.min(dist[i][j], dist[i][u] + dist[u][v] + dist[v][j]);
                            }
                            if (dist[i][v] != INF && dist[u][j] != INF) {
                                dist[i][j] = Math.min(dist[i][j], dist[i][v] + dist[v][u] + dist[u][j]);
                            }
                        }
                    }
                }
            } else {
                int u = query[1];
                int v = query[2];
                long shortestPath = dist[u][v];
                results.add(shortestPath == INF ? -1 : shortestPath);
            }
        }

        long[] finalResults = new long[results.size()];
        for (int i = 0; i < results.size(); i++) {
            finalResults[i] = results.get(i);
        }
        return finalResults;
    }
}