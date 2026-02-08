/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

typedef struct {
    int u, v, weight, index;
} Edge;

typedef struct {
    int parent;
    int rank;
} DSU;

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

int compareEdges(const void* a, const void* b) {
    Edge* edgeA = (Edge*)a;
    Edge* edgeB = (Edge*)b;
    return edgeA->weight - edgeB->weight;
}

int compareQueries(const void* a, const void* b) {
    Edge* queryA = (Edge*)a;
    Edge* queryB = (Edge*)b;
    return queryA->weight - queryB->weight;
}

bool* distanceLimitedPathsExist(int n, int** edgeList, int edgeListSize, int* edgeListColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;

    Edge* edges = (Edge*)malloc(edgeListSize * sizeof(Edge));
    for (int i = 0; i < edgeListSize; i++) {
        edges[i].u = edgeList[i][0];
        edges[i].v = edgeList[i][1];
        edges[i].weight = edgeList[i][2];
    }

    Edge* queryEdges = (Edge*)malloc(queriesSize * sizeof(Edge));
    for (int i = 0; i < queriesSize; i++) {
        queryEdges[i].u = queries[i][0];
        queryEdges[i].v = queries[i][1];
        queryEdges[i].weight = queries[i][2];
        queryEdges[i].index = i;
    }

    qsort(edges, edgeListSize, sizeof(Edge), compareEdges);
    qsort(queryEdges, queriesSize, sizeof(Edge), compareQueries);

    DSU* dsu = (DSU*)malloc(n * sizeof(DSU));
    for (int i = 0; i < n; i++) {
        dsu[i].parent = i;
        dsu[i].rank = 0;
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    int edgeIndex = 0;

    for (int i = 0; i < queriesSize; i++) {
        int limit = queryEdges[i].weight;

        while (edgeIndex < edgeListSize && edges[edgeIndex].weight < limit) {
            unionSets(dsu, edges[edgeIndex].u, edges[edgeIndex].v);
            edgeIndex++;
        }

        if (find(dsu, queryEdges[i].u) == find(dsu, queryEdges[i].v)) {
            result[queryEdges[i].index] = true;
        } else {
            result[queryEdges[i].index] = false;
        }
    }

    free(edges);
    free(queryEdges);
    free(dsu);

    return result;
}