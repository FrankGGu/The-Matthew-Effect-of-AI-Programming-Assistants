import java.util.*;

class Solution {
    public int[] shortestDistance(int n, int[][] edges, int[][] queries) {
        int[][] dist = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
            dist[i][i] = 0;
        }

        for (int[] edge : edges) {
            dist[edge[0]][edge[1]] = Math.min(dist[edge[0]][edge[1]], edge[2]);
            dist[edge[1]][edge[0]] = Math.min(dist[edge[1]][edge[0]], edge[2]);
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][k] != Integer.MAX_VALUE && dist[k][j] != Integer.MAX_VALUE) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        int q = queries.length;
        int[] result = new int[q];

        for (int i = 0; i < q; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            int w = queries[i][2];
            int minDist = dist[u][v];
            for (int[] edge : edges) {
                if (edge[0] == u && edge[1] == v) continue;
                minDist = Math.min(minDist, Math.min(dist[u][edge[0]] + w + dist[edge[1]][v], dist[u][edge[1]] + w + dist[edge[0]][v]));
            }
            result[i] = minDist == Integer.MAX_VALUE ? -1 : minDist;
        }

        return result;
    }
}