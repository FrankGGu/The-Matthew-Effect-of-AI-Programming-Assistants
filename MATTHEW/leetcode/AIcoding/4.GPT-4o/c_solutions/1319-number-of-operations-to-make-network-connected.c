int makeConnected(int n, int** connections, int connectionsSize, int* connectionsColSize) {
    if (connectionsSize < n - 1) return -1;

    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) parent[i] = i;

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
            parent[rootY] = rootX;
        }
    }

    for (int i = 0; i < connectionsSize; i++) {
        unionSets(connections[i][0], connections[i][1]);
    }

    int components = 0;
    for (int i = 0; i < n; i++) {
        if (parent[i] == i) components++;
    }

    free(parent);
    return components - 1;
}