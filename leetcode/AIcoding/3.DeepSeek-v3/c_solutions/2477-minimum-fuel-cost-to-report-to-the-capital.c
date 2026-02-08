int dfs(int node, int parent, int seats, long long* fuel, const int** graph, const int* graphSize) {
    int representatives = 1;
    for (int i = 0; i < graphSize[node]; i++) {
        int child = graph[node][i];
        if (child != parent) {
            representatives += dfs(child, node, seats, fuel, graph, graphSize);
        }
    }
    if (node != 0) {
        *fuel += (representatives + seats - 1) / seats;
    }
    return representatives;
}

long long minimumFuelCost(int** roads, int roadsSize, int* roadsColSize, int seats) {
    int n = roadsSize + 1;
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graphSize = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc((n) * sizeof(int));
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    long long fuel = 0;
    dfs(0, -1, seats, &fuel, (const int**)graph, (const int*)graphSize);

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);

    return fuel;
}