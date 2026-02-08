import java.util.*;

class Solution {
    public long[] shortestDistance(int n, int[][] edges, int[][] queries) {
        long[][] dist = new long[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Long.MAX_VALUE / 2);
            dist[i][i] = 0;
        }
        for (int[] edge : edges) {
            dist[edge[0]][edge[1]] = edge[2];
            dist[edge[1]][edge[0]] = edge[2];
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }

        long[] ans = new long[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            int w = queries[i][2];
            int a = queries[i][3];
            int b = queries[i][4];

            long min_dist = Math.min(dist[u][v], Math.min(dist[u][a] + w + dist[b][v], dist[u][b] + w + dist[a][v]));
            if (min_dist >= Long.MAX_VALUE / 2) {
                ans[i] = -1;
            } else {
                ans[i] = min_dist;
            }
        }

        return ans;
    }
}