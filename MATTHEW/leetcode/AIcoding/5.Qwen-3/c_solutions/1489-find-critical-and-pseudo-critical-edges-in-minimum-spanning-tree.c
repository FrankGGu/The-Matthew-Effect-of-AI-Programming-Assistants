#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int u;
    int v;
    int w;
} Edge;

typedef struct {
    Edge* edges;
    int n;
} Graph;

int compareEdges(const void* a, const void* b) {
    return ((Edge*)a)->w - ((Edge*)b)->w;
}

int find(int* parent, int x) {
    if (parent[x] != x)
        parent[x] = find(parent, parent[x]);
    return parent[x];
}

void unionSets(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY])
            parent[rootY] = rootX;
        else {
            parent[rootX] = rootY;
            if (rank[rootX] == rank[rootY])
                rank[rootY]++;
        }
    }
}

int kruskalMST(Graph* graph, int excludeEdgeIndex, int includeEdgeIndex) {
    int totalWeight = 0;
    int* parent = (int*)malloc((graph->n + 1) * sizeof(int));
    int* rank = (int*)malloc((graph->n + 1) * sizeof(int));
    for (int i = 0; i <= graph->n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int edgeCount = 0;
    int weight = 0;
    Edge* edges = graph->edges;

    if (includeEdgeIndex != -1) {
        Edge e = edges[includeEdgeIndex];
        unionSets(parent, rank, e.u, e.v);
        weight += e.w;
        edgeCount++;
    }

    for (int i = 0; i < graph->n - 1; i++) {
        if (i == excludeEdgeIndex) continue;
        Edge e = edges[i];
        int rootU = find(parent, e.u);
        int rootV = find(parent, e.v);
        if (rootU != rootV) {
            unionSets(parent, rank, e.u, e.v);
            weight += e.w;
            edgeCount++;
        }
    }

    free(parent);
    free(rank);

    return edgeCount == graph->n - 1 ? weight : INT_MAX;
}

int* findCriticalAndPseudoCriticalEdges(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    Graph graph;
    graph.n = n;
    graph.edges = (Edge*)malloc(edgesSize * sizeof(Edge));
    for (int i = 0; i < edgesSize; i++) {
        graph.edges[i].u = edges[i][0];
        graph.edges[i].v = edges[i][1];
        graph.edges[i].w = edges[i][2];
    }

    qsort(graph.edges, edgesSize, sizeof(Edge), compareEdges);

    int mstWeight = kruskalMST(&graph, -1, -1);

    int* critical = (int*)malloc(edgesSize * sizeof(int));
    int* pseudoCritical = (int*)malloc(edgesSize * sizeof(int));
    int criticalCount = 0;
    int pseudoCount = 0;

    for (int i = 0; i < edgesSize; i++) {
        int weightWithout = kruskalMST(&graph, i, -1);
        if (weightWithout > mstWeight) {
            critical[criticalCount++] = i;
        } else {
            int weightWith = kruskalMST(&graph, -1, i);
            if (weightWith == mstWeight) {
                pseudoCritical[pseudoCount++] = i;
            }
        }
    }

    int* result = (int*)malloc((criticalCount + pseudoCount) * sizeof(int));
    for (int i = 0; i < criticalCount; i++) {
        result[i] = critical[i];
    }
    for (int i = 0; i < pseudoCount; i++) {
        result[criticalCount + i] = pseudoCritical[i];
    }

    *returnSize = criticalCount + pseudoCount;
    free(critical);
    free(pseudoCritical);
    free(graph.edges);

    return result;
}