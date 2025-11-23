/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* bfs(int node, int** graph, int* graphColSize, int n) {
    int* dist = malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dist[i] = -1;
    int queue[n];
    int front = 0, rear = 0;
    dist[node] = 0;
    queue[rear++] = node;
    while (front < rear) {
        int curr = queue[front++];
        for (int i = 0; i < graphColSize[curr]; i++) {
            int neighbor = graph[curr][i];
            if (dist[neighbor] == -1) {
                dist[neighbor] = dist[curr] + 1;
                queue[rear++] = neighbor;
            }
        }
    }
    return dist;
}

int findDiameter(int** graph, int* graphColSize, int n) {
    int* dist = bfs(0, graph, graphColSize, n);
    int farthest = 0;
    for (int i = 1; i < n; i++) {
        if (dist[i] > dist[farthest]) farthest = i;
    }
    free(dist);

    dist = bfs(farthest, graph, graphColSize, n);
    int diameter = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] > diameter) diameter = dist[i];
    }
    free(dist);
    return diameter;
}

int minimumDiameterAfterMerge(int** edges1, int edges1Size, int* edges1ColSize, int** edges2, int edges2Size, int* edges2ColSize) {
    int n1 = edges1Size + 1;
    int n2 = edges2Size + 1;

    int** graph1 = malloc(n1 * sizeof(int*));
    int* graph1ColSize = calloc(n1, sizeof(int));
    int* graph1Degrees = calloc(n1, sizeof(int));
    for (int i = 0; i < n1; i++) {
        graph1[i] = malloc(2 * sizeof(int));
    }

    for (int i = 0; i < edges1Size; i++) {
        int u = edges1[i][0], v = edges1[i][1];
        graph1[u][graph1ColSize[u]++] = v;
        graph1[v][graph1ColSize[v]++] = u;
        graph1Degrees[u]++;
        graph1Degrees[v]++;
    }

    int** graph2 = malloc(n2 * sizeof(int*));
    int* graph2ColSize = calloc(n2, sizeof(int));
    int* graph2Degrees = calloc(n2, sizeof(int));
    for (int i = 0; i < n2; i++) {
        graph2[i] = malloc(2 * sizeof(int));
    }

    for (int i = 0; i < edges2Size; i++) {
        int u = edges2[i][0], v = edges2[i][1];
        graph2[u][graph2ColSize[u]++] = v;
        graph2[v][graph2ColSize[v]++] = u;
        graph2Degrees[u]++;
        graph2Degrees[v]++;
    }

    int d1 = findDiameter(graph1, graph1ColSize, n1);
    int d2 = findDiameter(graph2, graph2ColSize, n2);

    int r1 = (d1 + 1) / 2;
    int r2 = (d2 + 1) / 2;
    int candidate1 = r1 + r2 + 1;
    int candidate2 = (d1 > d2) ? d1 : d2;
    int result = (candidate1 > candidate2) ? candidate1 : candidate2;

    for (int i = 0; i < n1; i++) {
        free(graph1[i]);
    }
    free(graph1);
    free(graph1ColSize);
    free(graph1Degrees);

    for (int i = 0; i < n2; i++) {
        free(graph2[i]);
    }
    free(graph2);
    free(graph2ColSize);
    free(graph2Degrees);

    return result;
}