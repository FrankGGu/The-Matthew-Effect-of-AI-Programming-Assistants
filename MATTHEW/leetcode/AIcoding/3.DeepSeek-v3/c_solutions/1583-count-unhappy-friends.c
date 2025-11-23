int unhappyFriends(int n, int** preferences, int preferencesSize, int* preferencesColSize, int** pairs, int pairsSize, int* pairsColSize) {
    int rank[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n - 1; j++) {
            rank[i][preferences[i][j]] = j;
        }
    }

    int partner[n];
    for (int i = 0; i < n / 2; i++) {
        partner[pairs[i][0]] = pairs[i][1];
        partner[pairs[i][1]] = pairs[i][0];
    }

    int unhappy = 0;
    for (int x = 0; x < n; x++) {
        int y = partner[x];
        int idx = rank[x][y];
        for (int i = 0; i < idx; i++) {
            int u = preferences[x][i];
            int v = partner[u];
            if (rank[u][x] < rank[u][v]) {
                unhappy++;
                break;
            }
        }
    }
    return unhappy;
}