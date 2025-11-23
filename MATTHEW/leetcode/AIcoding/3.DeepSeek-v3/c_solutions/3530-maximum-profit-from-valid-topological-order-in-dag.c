int maxProfit(int n, int** edges, int edgesSize, int* edgesColSize, int* price, int priceSize) {
    int* indegree = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) graph[i][j] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
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

    int* maxP = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) maxP[i] = price[i];

    while (front < rear) {
        int u = queue[front++];
        for (int v = 0; v < n; v++) {
            if (graph[u][v]) {
                if (maxP[v] < maxP[u] + price[v]) {
                    maxP[v] = maxP[u] + price[v];
                }
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    int res = 0;
    for (int i = 0; i < n; i++) {
        if (maxP[i] > res) res = maxP[i];
    }

    free(indegree);
    for (int i = 0; i < n; i++) free(graph[i]);
    free(graph);
    free(queue);
    free(maxP);

    return res;
}