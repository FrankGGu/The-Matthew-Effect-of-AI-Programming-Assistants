/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** getAncestors(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize, int** returnColumnSizes) {
    int** graph = (int**)malloc(n * sizeof(int*));
    int* indegree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) graph[i][j] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graph[u][v] = 1;
        indegree[v]++;
    }

    int** ancestors = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        ancestors[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) ancestors[i][j] = 0;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        for (int v = 0; v < n; v++) {
            if (graph[u][v]) {
                ancestors[v][u] = 1;
                for (int i = 0; i < n; i++) {
                    if (ancestors[u][i]) ancestors[v][i] = 1;
                }
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        int count = 0;
        for (int j = 0; j < n; j++) {
            if (ancestors[i][j]) count++;
        }
        result[i] = (int*)malloc(count * sizeof(int));
        int idx = 0;
        for (int j = 0; j < n; j++) {
            if (ancestors[i][j]) {
                result[i][idx++] = j;
            }
        }
        (*returnColumnSizes)[i] = count;
    }

    for (int i = 0; i < n; i++) free(graph[i]);
    free(graph);
    free(indegree);
    for (int i = 0; i < n; i++) free(ancestors[i]);
    free(ancestors);
    free(queue);

    return result;
}