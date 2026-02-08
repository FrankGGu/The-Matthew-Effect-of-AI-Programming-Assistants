typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    int* edges;
    int* weights;
    int size;
    int capacity;
} AdjList;

void initAdjList(AdjList* adj, int n) {
    adj->edges = (int*)malloc(n * sizeof(int));
    adj->weights = (int*)malloc(n * sizeof(int));
    adj->size = 0;
    adj->capacity = n;
}

void addEdge(AdjList* adj, int node, int weight) {
    if (adj->size < adj->capacity) {
        adj->edges[adj->size] = node;
        adj->weights[adj->size] = weight;
        adj->size++;
    }
}

void dfs(int node, int parent, int depth, int dist, int* depths, int** parents, int** dists, AdjList* tree) {
    depths[node] = depth;
    parents[node][0] = parent;
    dists[node][0] = dist;

    for (int i = 1; (1 << i) <= depth; i++) {
        parents[node][i] = parents[parents[node][i-1]][i-1];
        dists[node][i] = dists[node][i-1] + dists[parents[node][i-1]][i-1];
    }

    for (int i = 0; i < tree[node].size; i++) {
        int child = tree[node].edges[i];
        int weight = tree[node].weights[i];
        if (child != parent) {
            dfs(child, node, depth + 1, weight, depths, parents, dists, tree);
        }
    }
}

int lca(int u, int v, int* depths, int** parents, int** dists, int* logn) {
    if (depths[u] < depths[v]) {
        int temp = u;
        u = v;
        v = temp;
    }

    int diff = depths[u] - depths[v];
    int res = 0;

    for (int i = 0; i < *logn; i++) {
        if ((diff >> i) & 1) {
            res += dists[u][i];
            u = parents[u][i];
        }
    }

    if (u == v) return res;

    for (int i = *logn - 1; i >= 0; i--) {
        if (parents[u][i] != parents[v][i]) {
            res += dists[u][i] + dists[v][i];
            u = parents[u][i];
            v = parents[v][i];
        }
    }

    res += dists[u][0] + dists[v][0];
    return res;
}

int* minOperationsQueries(int n, int** edges, int edgesSize, int* edgesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    AdjList* tree = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        initAdjList(&tree[i], n);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        addEdge(&tree[u], v, w);
        addEdge(&tree[v], u, w);
    }

    int logn = 0;
    while ((1 << logn) <= n) logn++;

    int* depths = (int*)malloc(n * sizeof(int));
    int** parents = (int**)malloc(n * sizeof(int*));
    int** dists = (int**)malloc(n * sizeof(int*));

    for (int i = 0; i < n; i++) {
        parents[i] = (int*)malloc(logn * sizeof(int));
        dists[i] = (int*)malloc(logn * sizeof(int));
        for (int j = 0; j < logn; j++) {
            parents[i][j] = -1;
            dists[i][j] = 0;
        }
    }

    dfs(0, -1, 0, 0, depths, parents, dists, tree);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        result[i] = lca(u, v, depths, parents, dists, &logn);
    }

    for (int i = 0; i < n; i++) {
        free(parents[i]);
        free(dists[i]);
        free(tree[i].edges);
        free(tree[i].weights);
    }
    free(tree);
    free(depths);
    free(parents);
    free(dists);

    return result;
}