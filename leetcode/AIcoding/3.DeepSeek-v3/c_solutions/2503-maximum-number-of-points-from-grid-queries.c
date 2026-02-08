typedef struct {
    int val;
    int idx;
} Query;

typedef struct {
    int x, y, val;
} Cell;

int cmpQuery(const void* a, const void* b) {
    return ((Query*)a)->val - ((Query*)b)->val;
}

int cmpCell(const void* a, const void* b) {
    return ((Cell*)a)->val - ((Cell*)b)->val;
}

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int* parent, int* rank, int* size, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
            size[rootY] += size[rootX];
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
            size[rootX] += size[rootY];
        }
    }
}

int* maxPoints(int** grid, int gridSize, int* gridColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;
    int* res = malloc(queriesSize * sizeof(int));
    Query* sortedQueries = malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i].val = queries[i][0];
        sortedQueries[i].idx = i;
    }
    qsort(sortedQueries, queriesSize, sizeof(Query), cmpQuery);

    int m = gridSize, n = gridColSize[0];
    Cell* cells = malloc(m * n * sizeof(Cell));
    int idx = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            cells[idx].x = i;
            cells[idx].y = j;
            cells[idx].val = grid[i][j];
            idx++;
        }
    }
    qsort(cells, m * n, sizeof(Cell), cmpCell);

    int total = m * n;
    int* parent = malloc(total * sizeof(int));
    int* rank = malloc(total * sizeof(int));
    int* compSize = malloc(total * sizeof(int));
    for (int i = 0; i < total; i++) {
        parent[i] = i;
        rank[i] = 0;
        compSize[i] = 1;
    }

    int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};
    int cellIdx = 0;
    int points = 0;

    for (int i = 0; i < queriesSize; i++) {
        int qVal = sortedQueries[i].val;

        while (cellIdx < m * n && cells[cellIdx].val < qVal) {
            int x = cells[cellIdx].x;
            int y = cells[cellIdx].y;
            int pos = x * n + y;

            for (int d = 0; d < 4; d++) {
                int nx = x + dirs[d][0];
                int ny = y + dirs[d][1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] < qVal) {
                    int nPos = nx * n + ny;
                    if (find(parent, pos) != find(parent, nPos)) {
                        unionSets(parent, rank, compSize, pos, nPos);
                    }
                }
            }
            cellIdx++;
        }

        if (grid[0][0] < qVal) {
            int root = find(parent, 0);
            res[sortedQueries[i].idx] = compSize[root];
        } else {
            res[sortedQueries[i].idx] = 0;
        }
    }

    free(sortedQueries);
    free(cells);
    free(parent);
    free(rank);
    free(compSize);

    return res;
}