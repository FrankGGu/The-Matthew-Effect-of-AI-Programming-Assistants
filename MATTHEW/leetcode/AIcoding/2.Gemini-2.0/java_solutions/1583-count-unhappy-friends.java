class Solution {
    public int unhappyFriends(int n, int[][] preferences, int[][] pairs) {
        int[] match = new int[n];
        for (int[] pair : pairs) {
            match[pair[0]] = pair[1];
            match[pair[1]] = pair[0];
        }

        int[][] rank = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n - 1; j++) {
                rank[i][preferences[i][j]] = j;
            }
        }

        int unhappyCount = 0;
        for (int x = 0; x < n; x++) {
            int y = match[x];
            for (int u = 0; u < n; u++) {
                if (u == x || u == y) continue;
                int v = match[u];
                if (rank[x][u] < rank[x][y] && rank[u][x] < rank[u][v]) {
                    unhappyCount++;
                    break;
                }
            }
        }

        return unhappyCount;
    }
}