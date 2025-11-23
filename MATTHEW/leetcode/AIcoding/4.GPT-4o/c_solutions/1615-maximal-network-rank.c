int maximalNetworkRank(int n, int** roads, int roadsSize, int* roadsColSize) {
    int degree[n];
    memset(degree, 0, sizeof(degree));
    bool connected[n][n];
    memset(connected, 0, sizeof(connected));

    for (int i = 0; i < roadsSize; i++) {
        degree[roads[i][0]]++;
        degree[roads[i][1]]++;
        connected[roads[i][0]][roads[i][1]] = true;
        connected[roads[i][1]][roads[i][0]] = true;
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