typedef struct {
    int* parent;
    int* size;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->size = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->size[i] = 1;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unite(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->size[rootX] < uf->size[rootY]) {
            uf->parent[rootX] = rootY;
            uf->size[rootY] += uf->size[rootX];
        } else {
            uf->parent[rootY] = rootX;
            uf->size[rootX] += uf->size[rootY];
        }
    }
}

int trapRainWater(int** heightMap, int heightMapSize, int* heightMapColSize) {
    if (heightMapSize <= 2 || heightMapColSize[0] <= 2) return 0;

    int m = heightMapSize;
    int n = heightMapColSize[0];
    int total = m * n;

    int* cells = (int*)malloc(total * sizeof(int));
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            cells[i * n + j] = i * n + j;
        }
    }

    for (int i = 0; i < total; i++) {
        for (int j = i + 1; j < total; j++) {
            int x1 = i / n, y1 = i % n;
            int x2 = j / n, y2 = j % n;
            if (heightMap[x1][y1] > heightMap[x2][y2]) {
                int temp = cells[i];
                cells[i] = cells[j];
                cells[j] = temp;
            }
        }
    }

    UnionFind* uf = createUnionFind(total + 1);
    int boundary = total;

    int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    int ans = 0;

    for (int i = 0; i < total; i++) {
        int idx = cells[i];
        int x = idx / n;
        int y = idx % n;
        int h = heightMap[x][y];

        for (int k = 0; k < 4; k++) {
            int nx = x + dirs[k][0];
            int ny = y + dirs[k][1];
            if (nx < 0 || nx >= m || ny < 0 || ny >= n) {
                unite(uf, idx, boundary);
            } else if (heightMap[nx][ny] >= h) {
                unite(uf, idx, nx * n + ny);
            }
        }

        if (find(uf, boundary) == find(uf, idx)) continue;

        ans += h - heightMap[x][y];
    }

    free(cells);
    free(uf->parent);
    free(uf->size);
    free(uf);

    return ans;
}