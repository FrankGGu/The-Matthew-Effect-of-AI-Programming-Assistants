class Solution {
    public int unhappyFriends(int n, int[][] preferences, int[][] pairs) {
        int[][] rank = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n - 1; j++) {
                rank[i][preferences[i][j]] = j;
            }
        }

        int[] pairMap = new int[n];
        for (int[] pair : pairs) {
            pairMap[pair[0]] = pair[1];
            pairMap[pair[1]] = pair[0];
        }

        int res = 0;
        for (int x = 0; x < n; x++) {
            int y = pairMap[x];
            for (int u : preferences[x]) {
                if (u == y) break;
                int v = pairMap[u];
                if (rank[u][x] < rank[u][v]) {
                    res++;
                    break;
                }
            }
        }
        return res;
    }
}