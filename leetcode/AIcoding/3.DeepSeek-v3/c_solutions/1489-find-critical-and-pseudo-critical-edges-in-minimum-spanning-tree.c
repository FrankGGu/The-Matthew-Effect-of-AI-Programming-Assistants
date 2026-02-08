int parent[100];

int find(int x) {
    if (parent[x] != x) {
        parent[x] = find(parent[x]);
    }
    return parent[x];
}

int unionSet(int x, int y) {
    int rx = find(x);
    int ry = find(y);
    if (rx == ry) return 0;
    parent[rx] = ry;
    return 1;
}

int cmp(const void* a, const void* b) {
    int* edge1 = *(int**)a;
    int* edge2 = *(int**)b;
    return edge1[2] - edge2[2];
}

int buildMST(int n, int** edges, int edgesSize, int* edgesColSize, int skip, int must) {
    for (int i = 0; i < n; i++) parent[i] = i;

    int weight = 0;
    int count = 0;

    if (must != -1) {
        unionSet(edges[must][0], edges[must][1]);
        weight += edges[must][2];
        count++;
    }

    for (int i = 0; i < edgesSize; i++) {
        if (i == skip) continue;
        if (unionSet(edges[i][0], edges[i][1])) {
            weight += edges[i][2];
            count++;
        }
    }

    return count == n - 1 ? weight : INT_MAX;
}

int** findCriticalAndPseudoCriticalEdges(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize, int** returnColumnSizes) {
    int** sortedEdges = (int**)malloc(edgesSize * sizeof(int*));
    for (int i = 0; i < edgesSize; i++) {
        sortedEdges[i] = (int*)malloc(4 * sizeof(int));
        sortedEdges[i][0] = edges[i][0];
        sortedEdges[i][1] = edges[i][1];
        sortedEdges[i][2] = edges[i][2];
        sortedEdges[i][3] = i;
    }

    qsort(sortedEdges, edgesSize, sizeof(int*), cmp);

    int originalMST = buildMST(n, sortedEdges, edgesSize, edgesColSize, -1, -1);

    int* critical = (int*)malloc(edgesSize * sizeof(int));
    int* pseudo = (int*)malloc(edgesSize * sizeof(int));
    int criticalCount = 0;
    int pseudoCount = 0;

    for (int i = 0; i < edgesSize; i++) {
        int idx = sortedEdges[i][3];

        if (buildMST(n, sortedEdges, edgesSize, edgesColSize, i, -1) > originalMST) {
            critical[criticalCount++] = idx;
        } else if (buildMST(n, sortedEdges, edgesSize, edgesColSize, -1, i) == originalMST) {
            pseudo[pseudoCount++] = idx;
        }
    }

    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = (int*)malloc(criticalCount * sizeof(int));
    result[1] = (int*)malloc(pseudoCount * sizeof(int));

    for (int i = 0; i < criticalCount; i++) result[0][i] = critical[i];
    for (int i = 0; i < pseudoCount; i++) result[1][i] = pseudo[i];

    *returnSize = 2;
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = criticalCount;
    (*returnColumnSizes)[1] = pseudoCount;

    free(critical);
    free(pseudo);
    for (int i = 0; i < edgesSize; i++) free(sortedEdges[i]);
    free(sortedEdges);

    return result;
}