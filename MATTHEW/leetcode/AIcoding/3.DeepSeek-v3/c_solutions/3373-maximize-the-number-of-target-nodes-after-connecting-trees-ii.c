/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* mostTargetedNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* degree = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) graph[i][j] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][v] = 1;
        graph[v][u] = 1;
        degree[u]++;
        degree[v]++;
    }

    int* targeted = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        targeted[i] = degree[i];
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (graph[i][j] == 0) {
                int count = degree[i] + degree[j];
                for (int k = 0; k < n; k++) {
                    if (k != i && k != j && graph[i][k] && graph[j][k]) {
                        count++;
                    }
                }
                if (count > targeted[i]) targeted[i] = count;
                if (count > targeted[j]) targeted[j] = count;
            }
        }
    }

    int maxTarget = 0;
    for (int i = 0; i < n; i++) {
        if (targeted[i] > maxTarget) {
            maxTarget = targeted[i];
        }
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (targeted[i] == maxTarget) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int idx = 0;
    for (int i = 0; i < n; i++) {
        if (targeted[i] == maxTarget) {
            result[idx++] = i;
        }
    }

    *returnSize = count;

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(degree);
    free(targeted);

    return result;
}