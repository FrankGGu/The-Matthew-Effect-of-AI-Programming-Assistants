bool validPath(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination) {
    if (source == destination) return true;

    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) parent[i] = i;

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        unionSet(edges[i][0], edges[i][1]);
    }

    return find(source) == find(destination);
}