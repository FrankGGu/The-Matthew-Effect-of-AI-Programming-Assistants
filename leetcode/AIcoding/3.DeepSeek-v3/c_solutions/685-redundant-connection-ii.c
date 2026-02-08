int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

int* findRedundantDirectedConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* parent = (int*)malloc((edgesSize + 1) * sizeof(int));
    int* candidate1 = NULL;
    int* candidate2 = NULL;
    int* last = NULL;
    int* inDegree = (int*)calloc(edgesSize + 1, sizeof(int));

    for (int i = 0; i <= edgesSize; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        if (inDegree[v] > 0) {
            candidate1 = edges[inDegree[v] - 1];
            candidate2 = edges[i];
            last = edges[i];
        } else {
            inDegree[v] = i + 1;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i] == last) continue;

        int u = edges[i][0];
        int v = edges[i][1];
        int pu = find(parent, u);
        int pv = find(parent, v);

        if (pu == pv) {
            if (candidate1 == NULL) {
                last = edges[i];
            } else {
                last = candidate1;
            }
            break;
        } else {
            parent[pv] = pu;
        }
    }

    free(parent);
    free(inDegree);

    *returnSize = 2;
    return last;
}