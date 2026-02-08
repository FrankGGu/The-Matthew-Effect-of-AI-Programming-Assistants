int countUnhappyFriends(int n, int** preferences, int preferencesSize, int* preferencesColSize, int* pairs, int pairsSize) {
    int unhappyCount = 0;
    int rank[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < preferencesColSize[i]; j++) {
            rank[i][preferences[i][j]] = j;
        }
    }

    for (int i = 0; i < pairsSize; i += 2) {
        int a = pairs[i], b = pairs[i + 1];
        for (int j = 0; j < preferencesColSize[a]; j++) {
            int x = preferences[a][j];
            if (x == b) break;
            if (rank[x][a] < rank[x][b]) {
                unhappyCount++;
                break;
            }
        }
        for (int j = 0; j < preferencesColSize[b]; j++) {
            int y = preferences[b][j];
            if (y == a) break;
            if (rank[y][b] < rank[y][a]) {
                unhappyCount++;
                break;
            }
        }
    }

    return unhappyCount;
}