#define MAX_N 100005

int* gardenNoAdj(int n, int** paths, int pathsSize, int* pathsColSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int graph[MAX_N][4] = {0}; 
    int degree[MAX_N] = {0};

    for (int i = 0; i < pathsSize; i++) {
        int u = paths[i][0] - 1;
        int v = paths[i][1] - 1;
        graph[u][degree[u]++] = v;
        graph[v][degree[v]++] = u;
    }

    for (int i = 0; i < n; i++) {
        int used[5] = {0};
        for (int j = 0; j < degree[i]; j++) {
            if (result[graph[i][j]] != 0) {
                used[result[graph[i][j]]] = 1;
            }
        }
        for (int color = 1; color <= 4; color++) {
            if (!used[color]) {
                result[i] = color;
                break;
            }
        }
    }

    *returnSize = n;
    return result;
}