class Solution {
    public int maximalNetworkRank(int n, int[][] roads) {
        int[] degree = new int[n];
        boolean[][] adj = new boolean[n][n];

        for (int[] road : roads) {
            int u = road[0];
            int v = road[1];
            degree[u]++;
            degree[v]++;
            adj[u][v] = true;
            adj[v][u] = true;
        }

        int maxRank = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int currentRank = degree[i] + degree[j];
                if (adj[i][j]) {
                    currentRank--;
                }
                maxRank = Math.max(maxRank, currentRank);
            }
        }

        return maxRank;
    }
}