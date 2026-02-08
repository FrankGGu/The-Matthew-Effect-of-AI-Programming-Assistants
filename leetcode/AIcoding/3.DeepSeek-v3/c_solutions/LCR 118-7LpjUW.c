int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

int* findRedundantConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* parent = (int*)malloc((edgesSize + 1) * sizeof(int));
    for (int i = 1; i <= edgesSize; i++) {
        parent[i] = i;
    }

    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int rootU = find(parent, u);
        int rootV = find(parent, v);

        if (rootU == rootV) {
            result[0] = u;
            result[1] = v;
        } else {
            parent[rootU] = rootV;
        }
    }

    free(parent);
    return result;
}