class Solution {
    public int unhappyFriends(int n, int[][] preferences, int[][] pairs) {
        int[][] preferenceRank = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n - 1; j++) {
                preferenceRank[i][preferences[i][j]] = j;
            }
        }

        int[] pairedWith = new int[n];
        for (int[] pair : pairs) {
            pairedWith[pair[0]] = pair[1];
            pairedWith[pair[1]] = pair[0];
        }

        int unhappyFriendsCount = 0;
        for (int x = 0; x < n; x++) {
            int y = pairedWith[x];
            for (int u = 0; u < n; u++) {
                if (u == x || u == y) {
                    continue;
                }
                int v = pairedWith[u];

                // Check if x prefers u over y AND u prefers x over v
                if (preferenceRank[x][u] < preferenceRank[x][y] &&
                    preferenceRank[u][x] < preferenceRank[u][v]) {
                    unhappyFriendsCount++;
                    break; // x is unhappy, no need to check other u's for this x
                }
            }
        }

        return unhappyFriendsCount;
    }
}