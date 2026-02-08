int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int* rank, int x, int y) {
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

bool isBipartite(int** graph, int graphSize, int* graphColSize) {
    int n = graphSize;
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < n; i++) {
        if (graphColSize[i] == 0) continue;

        int firstNeighbor = graph[i][0];
        for (int j = 0; j < graphColSize[i]; j++) {
            int neighbor = graph[i][j];
            if (find(parent, i) == find(parent, neighbor)) {
                free(parent);
                free(rank);
                return false;
            }
            unionSet(parent, rank, firstNeighbor, neighbor);
        }
    }

    free(parent);
    free(rank);
    return true;
}