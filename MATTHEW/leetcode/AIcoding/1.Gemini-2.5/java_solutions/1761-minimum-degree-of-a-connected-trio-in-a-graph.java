class Solution {
    public int minTrioDegree(int n, int[][] edges) {
        boolean[][] adj = new boolean[n + 1][n + 1];
        int[] degree = new int[n + 1];

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u][v] = true;
            adj[v][u] = true;
            degree[u]++;
            degree[v]++;
        }

        int minTrioDegree = Integer.MAX_VALUE;

        for (int i = 1; i <= n; i++) {
            for (int j = i + 1; j <= n; j++) {
                if (adj[i][j]) { // If i and j are connected
                    for (int k = j + 1; k <= n; k++) {
                        if (adj[i][k] && adj[j][k]) { // If i, j, k form a trio
                            int currentTrioDegree = degree[i] + degree[j] + degree[k] - 6;
                            minTrioDegree = Math.min(minTrioDegree, currentTrioDegree);
                        }
                    }
                }
            }
        }

        return minTrioDegree == Integer.MAX_VALUE ? -1 : minTrioDegree;
    }
}