typedef struct {
    int u, v, w;
} Edge;

int cmp(const void *a, const void *b) {
    return ((Edge *)a)->w - ((Edge *)b)->w;
}

int* modifyGraphEdges(int n, int m, int edges[m][3], int* returnSize) {
    Edge edgeList[m];
    for (int i = 0; i < m; i++) {
        edgeList[i].u = edges[i][0] - 1;
        edgeList[i].v = edges[i][1] - 1;
        edgeList[i].w = edges[i][2];
    }

    qsort(edgeList, m, sizeof(Edge), cmp);

    int *result = (int *)malloc(m * 3 * sizeof(int));
    int idx = 0;
    for (int i = 0; i < m; i++) {
        int newWeight = edgeList[i].w;
        if (edgeList[i].w % 2 == 0) {
            newWeight += 1;
        } else {
            newWeight += 2;
        }
        result[idx++] = edgeList[i].u + 1;
        result[idx++] = edgeList[i].v + 1;
        result[idx++] = newWeight;
    }

    *returnSize = m;
    return result;
}