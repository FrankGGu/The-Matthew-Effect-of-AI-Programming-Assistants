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
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int countComponents(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSets(parent, rank, edges[i][0], edges[i][1]);
    }

    int componentCount = 0;
    for (int i = 0; i < n; i++) {
        if (parent[i] == i) {
            componentCount++;
        }
    }

    free(parent);
    free(rank);
    return componentCount;
}