int findCircleNum(int** isConnected, int isConnectedSize, int* isConnectedColSize) {
    bool visited[200] = {false};
    int provinces = 0;

    void dfs(int node) {
        visited[node] = true;
        for (int i = 0; i < isConnectedSize; i++) {
            if (isConnected[node][i] == 1 && !visited[i]) {
                dfs(i);
            }
        }
    }

    for (int i = 0; i < isConnectedSize; i++) {
        if (!visited[i]) {
            dfs(i);
            provinces++;
        }
    }

    return provinces;
}