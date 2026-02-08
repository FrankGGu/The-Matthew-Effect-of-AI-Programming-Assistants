#define MAXN 100

int maxQuality(int** edges, int edgesSize, int* edgesColSize, int* values, int valuesSize, int start, int end, int maxTime) {
    int graph[MAXN][MAXN] = {0};
    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][edges[i][1]] = edges[i][2];
        graph[edges[i][1]][edges[i][0]] = edges[i][2];
    }

    int maxQuality = 0;
    int visited[MAXN] = {0};

    void dfs(int node, int timeSpent, int quality) {
        if (timeSpent > maxTime) return;
        if (node == end) {
            if (quality > maxQuality) maxQuality = quality;
            return;
        }
        visited[node] = 1;
        for (int next = 0; next < valuesSize; next++) {
            if (visited[next] == 0 && graph[node][next] > 0) {
                dfs(next, timeSpent + graph[node][next], quality + values[next]);
            }
        }
        visited[node] = 0;
    }

    dfs(start, 0, values[start]);

    return maxQuality;
}