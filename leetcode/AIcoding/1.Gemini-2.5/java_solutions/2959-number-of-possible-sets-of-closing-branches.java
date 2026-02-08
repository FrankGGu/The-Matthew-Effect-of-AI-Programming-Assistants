import java.util.Arrays;

class Solution {
    public int numberOfSets(int n, int maxDistance, int[][] roads) {
        int count = 0;

        for (int i = 0; i < (1 << n); i++) {
            long[][] currentDist = new long[n][n];

            for (int r = 0; r < n; r++) {
                Arrays.fill(currentDist[r], Long.MAX_VALUE / 2);
                currentDist[r][r] = 0;
            }

            for (int[] road : roads) {
                int u = road[0];
                int v = road[1];
                int d = road[2];

                if (((i >> u) & 1) == 1 && ((i >> v) & 1) == 1) {
                    currentDist[u][v] = Math.min(currentDist[u][v], d);
                    currentDist[v][u] = Math.min(currentDist[v][u], d);
                }
            }

            for (int k = 0; k < n; k++) {
                if (((i >> k) & 1) == 0) continue;

                for (int u = 0; u < n; u++) {
                    if (((i >> u) & 1) == 0) continue;

                    for (int v = 0; v < n; v++) {
                        if (((i >> v) & 1) == 0) continue;

                        if (currentDist[u][k] != Long.MAX_VALUE / 2 && currentDist[k][v] != Long.MAX_VALUE / 2) {
                            currentDist[u][v] = Math.min(currentDist[u][v], currentDist[u][k] + currentDist[k][v]);
                        }
                    }
                }
            }

            long maxPathInSubset = 0;
            boolean possible = true;

            for (int u = 0; u < n; u++) {
                if (((i >> u) & 1) == 0) continue;

                for (int v = 0; v < n; v++) {
                    if (((i >> v) & 1) == 0) continue;

                    if (u == v) continue;

                    if (currentDist[u][v] == Long.MAX_VALUE / 2) {
                        possible = false;
                        break;
                    }
                    maxPathInSubset = Math.max(maxPathInSubset, currentDist[u][v]);
                }
                if (!possible) break;
            }

            if (possible && maxPathInSubset <= maxDistance) {
                count++;
            }
        }

        return count;
    }
}