typedef struct {
    int node;
    int val;
} Pair;

int cmp(const void* a, const void* b) {
    return ((Pair*)b)->val - ((Pair*)a)->val;
}

int maxStarSum(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize, int k) {
    Pair** graph = (Pair**)malloc(valsSize * sizeof(Pair*));
    int* sizes = (int*)calloc(valsSize, sizeof(int));
    int* capacities = (int*)calloc(valsSize, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        if (sizes[u] == capacities[u]) {
            capacities[u] = capacities[u] == 0 ? 4 : capacities[u] * 2;
            graph[u] = (Pair*)realloc(graph[u], capacities[u] * sizeof(Pair));
        }
        graph[u][sizes[u]].node = v;
        graph[u][sizes[u]].val = vals[v];
        sizes[u]++;

        if (sizes[v] == capacities[v]) {
            capacities[v] = capacities[v] == 0 ? 4 : capacities[v] * 2;
            graph[v] = (Pair*)realloc(graph[v], capacities[v] * sizeof(Pair));
        }
        graph[v][sizes[v]].node = u;
        graph[v][sizes[v]].val = vals[u];
        sizes[v]++;
    }

    for (int i = 0; i < valsSize; i++) {
        if (sizes[i] > 0) {
            qsort(graph[i], sizes[i], sizeof(Pair), cmp);
        }
    }

    int maxSum = INT_MIN;
    for (int i = 0; i < valsSize; i++) {
        int sum = vals[i];
        int count = 0;
        for (int j = 0; j < sizes[i] && count < k; j++) {
            if (graph[i][j].val <= 0) break;
            sum += graph[i][j].val;
            count++;
        }
        if (sum > maxSum) maxSum = sum;
    }

    for (int i = 0; i < valsSize; i++) {
        if (graph[i]) free(graph[i]);
    }
    free(graph);
    free(sizes);
    free(capacities);

    return maxSum;
}