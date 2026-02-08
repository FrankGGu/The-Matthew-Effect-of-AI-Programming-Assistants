int minPrice = INT_MAX;

void dfs(int* price, int** graph, int* graphColSize, int node, int dest, int* visited, int cost, int* count, int n) {
    if (node == dest) {
        minPrice = fmin(minPrice, cost);
        return;
    }

    visited[node] = 1;

    for (int i = 0; i < graphColSize[node]; i++) {
        int next = graph[node][i];
        if (!visited[next]) {
            count[next]++;
            dfs(price, graph, graphColSize, next, dest, visited, cost + price[next], count, n);
            count[next]--;
        }
    }

    visited[node] = 0;
}

void backtrack(int* price, int* count, int node, int n, int cost, int* visited) {
    if (node == n) {
        minPrice = fmin(minPrice, cost);
        return;
    }

    backtrack(price, count, node + 1, n, cost + price[node] * count[node], visited);

    if (!visited[node]) {
        int temp = price[node];
        price[node] /= 2;
        visited[node] = 1;
        for (int i = 0; i < graphColSize[node]; i++) {
            visited[graph[node][i]] = 1;
        }

        backtrack(price, count, node + 1, n, cost + price[node] * count[node], visited);

        visited[node] = 0;
        for (int i = 0; i < graphColSize[node]; i++) {
            visited[graph[node][i]] = 0;
        }
        price[node] = temp;
    }
}

int** graph;
int* graphColSize;

int minimumTotalPrice(int n, int** edges, int edgesSize, int* edgesColSize, int* price, int priceSize, int** trips, int tripsSize, int* tripsColSize) {
    graph = malloc(n * sizeof(int*));
    graphColSize = calloc(n, sizeof(int));
    int* degree = calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        degree[u]++;
        degree[v]++;
    }

    for (int i = 0; i < n; i++) {
        graph[i] = malloc(degree[i] * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graph[u][graphColSize[u]++] = v;
        graph[v][graphColSize[v]++] = u;
    }

    int* count = calloc(n, sizeof(int));
    int* visited = calloc(n, sizeof(int));

    for (int i = 0; i < tripsSize; i++) {
        int start = trips[i][0], end = trips[i][1];
        count[start]++;
        minPrice = INT_MAX;
        dfs(price, graph, graphColSize, start, end, visited, price[start], count, n);
        count[start]--;
    }

    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    minPrice = INT_MAX;
    backtrack(price, count, 0, n, 0, visited);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphColSize);
    free(degree);
    free(count);
    free(visited);

    return minPrice;
}