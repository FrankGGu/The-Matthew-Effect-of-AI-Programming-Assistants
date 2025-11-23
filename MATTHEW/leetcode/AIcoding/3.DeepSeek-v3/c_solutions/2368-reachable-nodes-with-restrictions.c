/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int reachableNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* restricted, int restrictedSize) {
    int* graph[n];
    int graphSize[n];
    for (int i = 0; i < n; i++) {
        graph[i] = malloc(0);
        graphSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        graphSize[u]++;
        graph[u] = realloc(graph[u], graphSize[u] * sizeof(int));
        graph[u][graphSize[u] - 1] = v;

        graphSize[v]++;
        graph[v] = realloc(graph[v], graphSize[v] * sizeof(int));
        graph[v][graphSize[v] - 1] = u;
    }

    int* visited = calloc(n, sizeof(int));
    for (int i = 0; i < restrictedSize; i++) {
        visited[restricted[i]] = 1;
    }

    if (visited[0]) {
        for (int i = 0; i < n; i++) free(graph[i]);
        free(visited);
        return 0;
    }

    int* stack = malloc(n * sizeof(int));
    int top = 0;
    stack[top++] = 0;
    visited[0] = 1;
    int count = 0;

    while (top > 0) {
        int node = stack[--top];
        count++;

        for (int i = 0; i < graphSize[node]; i++) {
            int neighbor = graph[node][i];
            if (!visited[neighbor]) {
                visited[neighbor] = 1;
                stack[top++] = neighbor;
            }
        }
    }

    for (int i = 0; i < n; i++) free(graph[i]);
    free(visited);
    free(stack);

    return count;
}