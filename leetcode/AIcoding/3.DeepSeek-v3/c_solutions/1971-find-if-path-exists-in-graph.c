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

bool validPath(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination) {
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSets(parent, rank, edges[i][0], edges[i][1]);
    }

    bool result = (find(parent, source) == find(parent, destination));

    free(parent);
    free(rank);

    return result;
}