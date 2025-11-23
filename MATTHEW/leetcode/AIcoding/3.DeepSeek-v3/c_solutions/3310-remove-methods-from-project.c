/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* minRemoval(int n, int** dependencies, int dependenciesSize, int* dependenciesColSize, int* methods, int methodsSize, int* returnSize) {
    int* indegree = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < dependenciesSize; i++) {
        int u = dependencies[i][0];
        int v = dependencies[i][1];
        graph[u][v] = 1;
        indegree[v]++;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int* result = (int*)malloc(n * sizeof(int));
    int idx = 0;

    while (front < rear) {
        int u = queue[front++];
        result[idx++] = u;

        for (int v = 0; v < n; v++) {
            if (graph[u][v] == 1) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    int* res = (int*)malloc(methodsSize * sizeof(int));
    *returnSize = methodsSize;

    int* visited = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < idx; i++) {
        visited[result[i]] = 1;
    }

    int resIdx = 0;
    for (int i = 0; i < methodsSize; i++) {
        if (!visited[methods[i]]) {
            res[resIdx++] = methods[i];
        }
    }

    *returnSize = resIdx;

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(indegree);
    free(queue);
    free(result);
    free(visited);

    return res;
}