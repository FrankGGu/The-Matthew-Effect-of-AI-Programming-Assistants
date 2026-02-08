/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* timeTaken(int** edges, int edgesSize, int* edgesColSize, int n, int* returnSize) {
    *returnSize = n;
    int* res = (int*)malloc(n * sizeof(int));
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

    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        res[i] = 0;
        if (degree[i] == 1) {
            queue[rear++] = i;
        }
    }

    int time = 1;
    int remaining = n;

    while (remaining > 2) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int node = queue[front++];
            degree[node] = 0;
            remaining--;

            for (int j = 0; j < n; j++) {
                if (graph[node][j] && degree[j] > 0) {
                    degree[j]--;
                    if (degree[j] == 1) {
                        queue[rear++] = j;
                        res[j] = time;
                    }
                }
            }
        }
        time++;
    }

    while (front < rear) {
        int node = queue[front++];
        if (remaining > 0) {
            res[node] = time;
            remaining--;
        }
    }

    for (int i = 0; i < n; i++) free(graph[i]);
    free(graph);
    free(queue);
    free(degree);

    return res;
}