class Solution {
    public int numberOfSets(int n, int maxDistance, int[][] roads) {
        int res = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            if (check(n, maxDistance, roads, mask)) {
                res++;
            }
        }
        return res;
    }

    private boolean check(int n, int maxDistance, int[][] roads, int mask) {
        int[][] dist = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE / 2);
            dist[i][i] = 0;
        }
        for (int[] road : roads) {
            int u = road[0], v = road[1], w = road[2];
            if ((mask & (1 << u)) != 0 && (mask & (1 << v)) != 0) {
                dist[u][v] = Math.min(dist[u][v], w);
                dist[v][u] = Math.min(dist[v][u], w);
            }
        }
        for (int k = 0; k < n; k++) {
            if ((mask & (1 << k)) == 0) continue;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0) continue;
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) == 0) continue;
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) == 0) continue;
            for (int j = i + 1; j < n; j++) {
                if ((mask & (1 << j)) == 0) continue;
                if (dist[i][j] > maxDistance) {
                    return false;
                }
            }
        }
        return true;
    }
}