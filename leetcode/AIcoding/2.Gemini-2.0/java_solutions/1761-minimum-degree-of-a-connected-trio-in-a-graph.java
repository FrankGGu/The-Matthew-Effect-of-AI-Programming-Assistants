import java.util.Arrays;

class Solution {
    public int minTrioDegree(int n, int[][] edges) {
        int[][] adj = new int[n][n];
        int[] degree = new int[n];
        for (int[] edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            adj[u][v] = 1;
            adj[v][u] = 1;
            degree[u]++;
            degree[v]++;
        }

        int minDegree = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (adj[i][j] == 1) {
                    for (int k = j + 1; k < n; k++) {
                        if (adj[i][k] == 1 && adj[j][k] == 1) {
                            minDegree = Math.min(minDegree, degree[i] + degree[j] + degree[k] - 6);
                        }
                    }
                }
            }
        }

        return minDegree == Integer.MAX_VALUE ? -1 : minDegree;
    }
}