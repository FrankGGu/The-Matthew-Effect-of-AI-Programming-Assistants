int maximalNetworkRank(int n, int** roads, int roadsSize, int* roadsColSize) {
    int degree[n];
    int connected[n][n];
    memset(degree, 0, sizeof(degree));
    memset(connected, 0, sizeof(connected));

    for (int i = 0; i < roadsSize; i++) {
        int a = roads[i][0];
        int b = roads[i][1];
        degree[a]++;
        degree[b]++;
        connected[a][b] = 1;
        connected[b][a] = 1;
    }

    int maxRank = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int rank = degree[i] + degree[j];
            if (connected[i][j]) {
                rank--;
            }
            if (rank > maxRank) {
                maxRank = rank;
            }
        }
    }

    return maxRank;
}