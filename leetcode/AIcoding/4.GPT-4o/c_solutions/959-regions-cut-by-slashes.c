#define MAX 100

int regionsBySlashes(char ** grid, int gridSize) {
    int parent[MAX * MAX];
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
            parent[rootX] = rootY;
        }
    }

    int n = gridSize;
    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            parent[count] = count;
            count++;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '/') {
                union_set(i * n + j, i * n + j + 1);
                union_set(i * n + j + 1, (i + 1) * n + j);
            } else if (grid[i][j] == '\\') {
                union_set(i * n + j, (i + 1) * n + j + 1);
                union_set(i * n + j + 1, i * n + j);
            } else {
                union_set(i * n + j, i * n + j + 1);
                union_set(i * n + j + 1, (i + 1) * n + j);
                union_set((i + 1) * n + j, (i + 1) * n + j + 1);
            }
        }
    }

    int regions = 0;
    for (int i = 0; i < count; i++) {
        if (parent[i] == i) {
            regions++;
        }
    }

    return regions;
}