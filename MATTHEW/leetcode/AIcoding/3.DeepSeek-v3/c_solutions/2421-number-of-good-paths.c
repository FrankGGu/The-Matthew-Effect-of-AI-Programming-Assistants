typedef struct {
    int parent;
    int rank;
} DSU;

DSU* createDSU(int n) {
    DSU* dsu = (DSU*)malloc(n * sizeof(DSU));
    for (int i = 0; i < n; i++) {
        dsu[i].parent = i;
        dsu[i].rank = 0;
    }
    return dsu;
}

int find(DSU* dsu, int x) {
    if (dsu[x].parent != x) {
        dsu[x].parent = find(dsu, dsu[x].parent);
    }
    return dsu[x].parent;
}

void unionSets(DSU* dsu, int x, int y) {
    int rootX = find(dsu, x);
    int rootY = find(dsu, y);
    if (rootX != rootY) {
        if (dsu[rootX].rank < dsu[rootY].rank) {
            dsu[rootX].parent = rootY;
        } else if (dsu[rootX].rank > dsu[rootY].rank) {
            dsu[rootY].parent = rootX;
        } else {
            dsu[rootY].parent = rootX;
            dsu[rootX].rank++;
        }
    }
}

int cmp(const void* a, const void* b) {
    int* aa = *(int**)a;
    int* bb = *(int**)b;
    return aa[2] - bb[2];
}

int numberOfGoodPaths(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = valsSize;
    int** sortedEdges = (int**)malloc(edgesSize * sizeof(int*));
    for (int i = 0; i < edgesSize; i++) {
        sortedEdges[i] = (int*)malloc(3 * sizeof(int));
        sortedEdges[i][0] = edges[i][0];
        sortedEdges[i][1] = edges[i][1];
        sortedEdges[i][2] = (vals[edges[i][0]] > vals[edges[i][1]]) ? vals[edges[i][0]] : vals[edges[i][1]];
    }

    qsort(sortedEdges, edgesSize, sizeof(sortedEdges[0]), cmp);

    DSU* dsu = createDSU(n);
    int* count = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        count[i] = 1;
    }

    int result = n;

    for (int i = 0; i < edgesSize; i++) {
        int u = sortedEdges[i][0];
        int v = sortedEdges[i][1];
        int maxVal = sortedEdges[i][2];

        int rootU = find(dsu, u);
        int rootV = find(dsu, v);

        if (vals[rootU] == maxVal && vals[rootV] == maxVal) {
            result += count[rootU] * count[rootV];
            unionSets(dsu, rootU, rootV);
            int newRoot = find(dsu, rootU);
            count[newRoot] = count[rootU] + count[rootV];
        } else if (vals[rootU] == maxVal) {
            unionSets(dsu, rootU, rootV);
            int newRoot = find(dsu, rootU);
            count[newRoot] = count[rootU];
        } else if (vals[rootV] == maxVal) {
            unionSets(dsu, rootU, rootV);
            int newRoot = find(dsu, rootU);
            count[newRoot] = count[rootV];
        } else {
            unionSets(dsu, rootU, rootV);
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        free(sortedEdges[i]);
    }
    free(sortedEdges);
    free(dsu);
    free(count);

    return result;
}