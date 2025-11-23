int countWays(int** edges, int edgesSize, int* edgesColSize, int n) {
    int degree[n];
    memset(degree, 0, sizeof(degree));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        degree[u]++;
        degree[v]++;
    }

    long long result = 1;
    for (int i = 0; i < n; i++) {
        result = (result * (n - degree[i])) % 1000000007;
    }

    return result;
}