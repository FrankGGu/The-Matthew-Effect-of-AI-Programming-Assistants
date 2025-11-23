import java.util.Arrays;

class Solution {
    public int numberOfSets(int n, int maxDistance, int[][] roads) {
        int m = roads.length;
        int ans = 0;
        for (int i = 0; i < (1 << n); i++) {
            int[][] dist = new int[n][n];
            for (int[] row : dist) {
                Arrays.fill(row, Integer.MAX_VALUE / 2);
            }
            for (int j = 0; j < n; j++) {
                if ((i & (1 << j)) != 0) {
                    dist[j][j] = 0;
                }
            }

            int cost = 0;
            for (int[] road : roads) {
                int u = road[0];
                int v = road[1];
                int w = road[2];
                if ((i & (1 << u)) != 0 && (i & (1 << v)) != 0) {
                    dist[u][v] = Math.min(dist[u][v], w);
                    dist[v][u] = Math.min(dist[v][u], w);
                }
            }

            for (int k = 0; k < n; k++) {
                for (int u = 0; u < n; u++) {
                    for (int v = 0; v < n; v++) {
                        dist[u][v] = Math.min(dist[u][v], dist[u][k] + dist[k][v]);
                    }
                }
            }

            boolean valid = true;
            for (int u = 0; u < n; u++) {
                if ((i & (1 << u)) != 0) {
                    for (int v = 0; v < n; v++) {
                        if ((i & (1 << v)) != 0) {
                            if (dist[u][v] > maxDistance) {
                                valid = false;
                                break;
                            }
                        }
                    }
                }
                if (!valid) break;
            }

            if (valid) ans++;
        }
        return ans;
    }
}