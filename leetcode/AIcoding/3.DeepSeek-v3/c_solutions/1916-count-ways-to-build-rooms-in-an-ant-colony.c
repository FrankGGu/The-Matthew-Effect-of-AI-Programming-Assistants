int mod = 1000000007;

long long power(long long x, long long y) {
    long long res = 1;
    x %= mod;
    while (y > 0) {
        if (y & 1) res = (res * x) % mod;
        y >>= 1;
        x = (x * x) % mod;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, mod - 2);
}

int dfs(int u, int* children_count, int** graph, int* graph_size) {
    long long res = 1;
    for (int i = 0; i < graph_size[u]; i++) {
        int v = graph[u][i];
        res = (res * dfs(v, children_count, graph, graph_size)) % mod;
        children_count[u] += children_count[v];
    }
    children_count[u]++;
    return res * children_count[u] % mod;
}

int waysToBuildRooms(int* prevRoom, int prevRoomSize) {
    int n = prevRoomSize;
    int* children_count = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    int* graph_size = (int*)calloc(n, sizeof(int));
    int* graph_capacity = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        graph_capacity[i] = 10;
        graph[i] = (int*)malloc(graph_capacity[i] * sizeof(int));
    }

    for (int i = 1; i < n; i++) {
        int parent = prevRoom[i];
        if (graph_size[parent] >= graph_capacity[parent]) {
            graph_capacity[parent] *= 2;
            graph[parent] = (int*)realloc(graph[parent], graph_capacity[parent] * sizeof(int));
        }
        graph[parent][graph_size[parent]++] = i;
    }

    long long numerator = dfs(0, children_count, graph, graph_size);
    long long denominator = 1;
    for (int i = 0; i < n; i++) {
        denominator = (denominator * children_count[i]) % mod;
    }

    long long inv_denom = modInverse(denominator);
    long long fact = 1;
    for (int i = 1; i <= n; i++) {
        fact = (fact * i) % mod;
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graph_size);
    free(graph_capacity);
    free(children_count);

    return fact * numerator % mod * inv_denom % mod;
}