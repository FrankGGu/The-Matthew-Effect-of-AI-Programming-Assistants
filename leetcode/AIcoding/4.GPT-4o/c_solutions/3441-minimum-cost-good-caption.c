int minimumCost(int n, int* connections, int connectionsSize) {
    int parent[n + 1];
    for (int i = 0; i <= n; i++) parent[i] = i;

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void union_set(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }

    for (int i = 0; i < connectionsSize; i += 3) {
        union_set(connections[i], connections[i + 1]);
    }

    int totalCost = 0;
    int componentCount = 0;

    for (int i = 1; i <= n; i++) {
        if (find(i) == i) {
            componentCount++;
            totalCost += connections[i - 1] > 0 ? connections[i - 1] : 0;
        }
    }

    return (componentCount == 1) ? totalCost : -1;
}