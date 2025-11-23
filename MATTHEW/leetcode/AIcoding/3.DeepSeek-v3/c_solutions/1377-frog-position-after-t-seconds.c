double frogPosition(int n, int** edges, int edgesSize, int* edgesColSize, int t, int target){
    if (n == 1) return 1.0;

    int** graph = (int**)malloc((n + 1) * sizeof(int*));
    int* degree = (int*)calloc(n + 1, sizeof(int));
    for (int i = 0; i <= n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][degree[u]++] = v;
        graph[v][degree[v]++] = u;
    }

    double* prob = (double*)calloc(n + 1, sizeof(double));
    int* visited = (int*)calloc(n + 1, sizeof(int));
    prob[1] = 1.0;
    visited[1] = 1;

    int queue[n * n];
    int front = 0, rear = 0;
    queue[rear++] = 1;

    for (int time = 0; time < t; time++) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int node = queue[front++];
            int count = 0;
            for (int j = 0; j < degree[node]; j++) {
                int neighbor = graph[node][j];
                if (!visited[neighbor]) count++;
            }

            if (count == 0) continue;

            double p = prob[node] / count;
            for (int j = 0; j < degree[node]; j++) {
                int neighbor = graph[node][j];
                if (!visited[neighbor]) {
                    visited[neighbor] = 1;
                    prob[neighbor] = p;
                    queue[rear++] = neighbor;
                }
            }
            prob[node] = 0.0;
        }
    }

    double result = prob[target];

    for (int i = 0; i <= n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(degree);
    free(prob);
    free(visited);

    return result;
}