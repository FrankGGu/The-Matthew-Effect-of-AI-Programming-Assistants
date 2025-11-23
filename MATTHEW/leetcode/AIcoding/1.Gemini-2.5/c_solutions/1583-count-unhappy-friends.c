int countUnhappyFriends(int n, int** preferences, int preferencesSize, int* preferencesColSize, int** pairs, int pairsSize, int* pairsColSize) {
    int rank[n][n];

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n - 1; ++j) {
            rank[i][preferences[i][j]] = j;
        }
    }

    int partner[n];

    for (int i = 0; i < pairsSize; ++i) {
        int x = pairs[i][0];
        int y = pairs[i][1];
        partner[x] = y;
        partner[y] = x;
    }

    int unhappy_friends_count = 0;

    for (int x = 0; x < n; ++x) {
        int y = partner[x];

        for (int i = 0; i < rank[x][y]; ++i) {
            int u = preferences[x][i];

            int v = partner[u];

            if (rank[u][x] < rank[u][v]) {
                unhappy_friends_count++;
                break;
            }
        }
    }

    return unhappy_friends_count;
}