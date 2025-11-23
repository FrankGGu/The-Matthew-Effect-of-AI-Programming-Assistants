int countCompleteComponents(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    int* size = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        size[i] = 1;
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSets(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (size[rootX] < size[rootY]) {
                parent[rootX] = rootY;
                size[rootY] += size[rootX];
            } else {
                parent[rootY] = rootX;
                size[rootX] += size[rootY];
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSets(edges[i][0], edges[i][1]);
    }

    int* componentSize = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        int root = find(i);
        componentSize[root]++;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (componentSize[i] > 0) {
            int expectedEdges = componentSize[i] * (componentSize[i] - 1) / 2;
            int actualEdges = 0;
            for (int j = 0; j < edgesSize; j++) {
                if (find(edges[j][0]) == i || find(edges[j][1]) == i) {
                    actualEdges++;
                }
            }
            if (expectedEdges == actualEdges) {
                count++;
            }
        }
    }

    free(parent);
    free(size);
    free(componentSize);
    return count;
}