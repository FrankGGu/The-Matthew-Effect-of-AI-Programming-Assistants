typedef struct {
    int parent;
    int rank;
    int weight;
} DSU;

DSU* createDSU(int n) {
    DSU* dsu = (DSU*)malloc(n * sizeof(DSU));
    for (int i = 0; i < n; i++) {
        dsu[i].parent = i;
        dsu[i].rank = 0;
        dsu[i].weight = INT_MAX;
    }
    return dsu;
}

int find(DSU* dsu, int x) {
    if (dsu[x].parent != x) {
        dsu[x].parent = find(dsu, dsu[x].parent);
    }
    return dsu[x].parent;
}

void unionSets(DSU* dsu, int x, int y, int w) {
    int rootX = find(dsu, x);
    int rootY = find(dsu, y);

    if (rootX != rootY) {
        if (dsu[rootX].rank < dsu[rootY].rank) {
            dsu[rootX].parent = rootY;
            dsu[rootY].weight &= dsu[rootX].weight;
        } else if (dsu[rootX].rank > dsu[rootY].rank) {
            dsu[rootY].parent = rootX;
            dsu[rootX].weight &= dsu[rootY].weight;
        } else {
            dsu[rootY].parent = rootX;
            dsu[rootX].rank++;
            dsu[rootX].weight &= dsu[rootY].weight;
        }
    }
    dsu[rootX].weight &= w;
    dsu[rootY].weight &= w;
}

int* minimumCost(int n, int** edges, int edgesSize, int* edgesColSize, int** query, int querySize, int* queryColSize, int* returnSize) {
    DSU* dsu = createDSU(n);

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        unionSets(dsu, u, v, w);
    }

    int* result = (int*)malloc(querySize * sizeof(int));
    *returnSize = querySize;

    for (int i = 0; i < querySize; i++) {
        int s = query[i][0];
        int t = query[i][1];

        if (s == t) {
            result[i] = 0;
            continue;
        }

        int rootS = find(dsu, s);
        int rootT = find(dsu, t);

        if (rootS != rootT) {
            result[i] = -1;
        } else {
            result[i] = dsu[rootS].weight;
        }
    }

    free(dsu);
    return result;
}