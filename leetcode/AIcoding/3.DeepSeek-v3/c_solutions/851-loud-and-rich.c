/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* loudAndRich(int** richer, int richerSize, int* richerColSize, int* quiet, int quietSize, int* returnSize) {
    *returnSize = quietSize;
    int* result = (int*)malloc(quietSize * sizeof(int));
    for (int i = 0; i < quietSize; i++) {
        result[i] = i;
    }

    int* indegree = (int*)calloc(quietSize, sizeof(int));
    int** graph = (int**)malloc(quietSize * sizeof(int*));
    int* graphSize = (int*)calloc(quietSize, sizeof(int));
    int* graphCapacity = (int*)malloc(quietSize * sizeof(int));

    for (int i = 0; i < quietSize; i++) {
        graphCapacity[i] = 10;
        graph[i] = (int*)malloc(graphCapacity[i] * sizeof(int));
    }

    for (int i = 0; i < richerSize; i++) {
        int u = richer[i][1];
        int v = richer[i][0];
        if (graphSize[u] >= graphCapacity[u]) {
            graphCapacity[u] *= 2;
            graph[u] = (int*)realloc(graph[u], graphCapacity[u] * sizeof(int));
        }
        graph[u][graphSize[u]++] = v;
        indegree[v]++;
    }

    int* queue = (int*)malloc(quietSize * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < quietSize; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            if (quiet[result[u]] < quiet[result[v]]) {
                result[v] = result[u];
            }
            indegree[v]--;
            if (indegree[v] == 0) {
                queue[rear++] = v;
            }
        }
    }

    for (int i = 0; i < quietSize; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(graphCapacity);
    free(indegree);
    free(queue);

    return result;
}