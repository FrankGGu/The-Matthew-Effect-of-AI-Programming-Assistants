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

        int minDegree = Integer.MAX_VALUE;

        for (int i = 1; i <= n; i++) {
            for (int j = i + 1; j <= n; j++) {
                if (!adj[i][j]) continue;
                for (int k = j + 1; k <= n; k++) {
                    if (adj[i][k] && adj[j][k]) {
                        int trioDegree = degree[i] + degree[j] + degree[k] - 6;
                        minDegree = Math.min(minDegree, trioDegree);
                    }
                }
            }
        }

        return minDegree == Integer.MAX_VALUE ? -1 : minDegree;
    }
}