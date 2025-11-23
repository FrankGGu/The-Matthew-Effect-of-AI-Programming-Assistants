int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int *parent, int *rank, int x, int y) {
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

int regionsBySlashes(char** grid, int gridSize) {
    int n = gridSize;
    int total = 4 * n * n;
    int *parent = (int *)malloc(total * sizeof(int));
    int *rank = (int *)malloc(total * sizeof(int));

    for (int i = 0; i < total; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int base = 4 * (i * n + j);

            if (grid[i][j] == ' ') {
                unionSets(parent, rank, base, base + 1);
                unionSets(parent, rank, base + 1, base + 2);
                unionSets(parent, rank, base + 2, base + 3);
            } else if (grid[i][j] == '/') {
                unionSets(parent, rank, base, base + 3);
                unionSets(parent, rank, base + 1, base + 2);
            } else {
                unionSets(parent, rank, base, base + 1);
                unionSets(parent, rank, base + 2, base + 3);
            }

            if (j + 1 < n) {
                int rightBase = 4 * (i * n + j + 1);
                unionSets(parent, rank, base + 1, rightBase + 3);
            }
            if (i + 1 < n) {
                int downBase = 4 * ((i + 1) * n + j);
                unionSets(parent, rank, base + 2, downBase);
            }
        }
    }

    int regions = 0;
    for (int i = 0; i < total; i++) {
        if (find(parent, i) == i) {
            regions++;
        }
    }

    free(parent);
    free(rank);
    return regions;
}