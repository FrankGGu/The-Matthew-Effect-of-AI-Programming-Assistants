bool possibleBipartition(int n, int** dislikes, int dislikesSize, int* dislikesColSize) {
    int *color = (int *)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) color[i] = -1;

    void dfs(int node, int c) {
        color[node] = c;
        for (int i = 0; i < dislikesSize; i++) {
            if (dislikes[i][0] == node || dislikes[i][1] == node) {
                int neighbor = dislikes[i][0] == node ? dislikes[i][1] : dislikes[i][0];
                if (color[neighbor] == -1) {
                    dfs(neighbor, 1 - c);
                }
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        if (color[i] == -1) {
            dfs(i, 0);
        }
    }

    for (int i = 0; i < dislikesSize; i++) {
        if (color[dislikes[i][0]] == color[dislikes[i][1]]) {
            free(color);
            return false;
        }
    }

    free(color);
    return true;
}