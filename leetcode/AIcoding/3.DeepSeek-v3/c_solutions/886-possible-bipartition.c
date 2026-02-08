int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

bool possibleBipartition(int n, int** dislikes, int dislikesSize, int* dislikesColSize) {
    int* parent = (int*)malloc((n + 1) * sizeof(int));
    int* rank = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int** graph = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        graph[i] = (int*)malloc(0);
    }
    int* graphSize = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i < dislikesSize; i++) {
        int a = dislikes[i][0];
        int b = dislikes[i][1];

        graph[a] = (int*)realloc(graph[a], (graphSize[a] + 1) * sizeof(int));
        graph[a][graphSize[a]++] = b;

        graph[b] = (int*)realloc(graph[b], (graphSize[b] + 1) * sizeof(int));
        graph[b][graphSize[b]++] = a;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < graphSize[i]; j++) {
            int neighbor = graph[i][j];
            if (find(parent, i) == find(parent, neighbor)) {
                for (int k = 0; k <= n; k++) free(graph[k]);
                free(graph);
                free(graphSize);
                free(parent);
                free(rank);
                return false;
            }
            unionSets(parent, rank, graph[i][0], neighbor);
        }
    }

    for (int i = 0; i <= n; i++) free(graph[i]);
    free(graph);
    free(graphSize);
    free(parent);
    free(rank);
    return true;
}