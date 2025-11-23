typedef struct {
    int node;
    int val;
} Pair;

int cmp(const void* a, const void* b) {
    return ((Pair*)b)->val - ((Pair*)a)->val;
}

int maximumScore(int* scores, int scoresSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = scoresSize;
    Pair** graph = (Pair**)malloc(n * sizeof(Pair*));
    int* size = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        graph[i] = (Pair*)malloc(4 * sizeof(Pair));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        graph[u][size[u]].node = v;
        graph[u][size[u]].val = scores[v];
        size[u]++;

        graph[v][size[v]].node = u;
        graph[v][size[v]].val = scores[u];
        size[v]++;
    }

    for (int i = 0; i < n; i++) {
        if (size[i] > 3) {
            qsort(graph[i], size[i], sizeof(Pair), cmp);
            size[i] = 3;
        }
    }

    int res = -1;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int base = scores[u] + scores[v];

        for (int j = 0; j < size[u] && j < 3; j++) {
            int x = graph[u][j].node;
            if (x == v) continue;

            for (int k = 0; k < size[v] && k < 3; k++) {
                int y = graph[v][k].node;
                if (y == u || y == x) continue;

                res = fmax(res, base + scores[x] + scores[y]);
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(size);

    return res;
}