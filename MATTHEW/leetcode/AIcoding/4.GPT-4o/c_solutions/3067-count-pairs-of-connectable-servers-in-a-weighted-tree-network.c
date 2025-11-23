#define MAXN 100001

int countPairs(int n, int** edges, int edgesSize, int* edgesColSize) {
    int graph[MAXN][MAXN] = {0};
    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][edges[i][1]] = 1;
        graph[edges[i][1]][edges[i][0]] = 1;
    }

    long long totalPairs = 0;
    long long size[MAXN] = {0};
    int visited[MAXN] = {0};

    void dfs(int node) {
        visited[node] = 1;
        size[node] = 1;
        for (int neighbor = 0; neighbor < n; neighbor++) {
            if (graph[node][neighbor] && !visited[neighbor]) {
                dfs(neighbor);
                size[node] += size[neighbor];
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
            totalPairs += size[i] * (n - size[i]);
        }
    }

    return totalPairs / 2;
}