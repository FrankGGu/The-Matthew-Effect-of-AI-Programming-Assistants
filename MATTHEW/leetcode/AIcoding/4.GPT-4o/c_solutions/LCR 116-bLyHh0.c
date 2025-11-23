int findCircleNum(int** isConnected, int isConnectedSize, int* isConnectedColSize) {
    int count = 0;
    int* visited = (int*)malloc(isConnectedSize * sizeof(int));
    for (int i = 0; i < isConnectedSize; i++) visited[i] = 0;

    void dfs(int node) {
        visited[node] = 1;
        for (int j = 0; j < isConnectedSize; j++) {
            if (isConnected[node][j] == 1 && !visited[j]) {
                dfs(j);
            }
        }
    }

    for (int i = 0; i < isConnectedSize; i++) {
        if (!visited[i]) {
            count++;
            dfs(i);
        }
    }

    free(visited);
    return count;
}