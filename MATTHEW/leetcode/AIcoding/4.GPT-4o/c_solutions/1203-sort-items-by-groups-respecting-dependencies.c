#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 1000

typedef struct {
    int *edges;
    int size;
} Graph;

Graph *createGraph(int n) {
    Graph *g = (Graph *)malloc(sizeof(Graph));
    g->edges = (int *)malloc(n * sizeof(int));
    memset(g->edges, 0, n * sizeof(int));
    g->size = n;
    return g;
}

void addEdge(Graph *g, int u, int v) {
    g->edges[u] |= (1 << v);
}

int topologicalSort(Graph *g, int n, int *result) {
    int inDegree[MAXN] = {0};
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (g->edges[i] & (1 << j)) {
                inDegree[j]++;
            }
        }
    }

    int queue[MAXN], front = 0, rear = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int index = 0;
    while (front < rear) {
        int u = queue[front++];
        result[index++] = u;
        for (int v = 0; v < n; v++) {
            if (g->edges[u] & (1 << v)) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    return index == n;
}

int sortItems(int n, int m, int **group, int groupSize, int **beforeItems, int beforeItemsSize, int **returnSize) {
    for (int i = 0; i < n; i++) {
        if (group[i] == -1) {
            group[i] = m++;
        }
    }

    Graph *itemGraph = createGraph(n);
    Graph *groupGraph = createGraph(m);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < beforeItemsSize; j++) {
            for (int k = 0; k < beforeItems[j][0]; k++) {
                addEdge(itemGraph, beforeItems[j][k], i);
                if (group[beforeItems[j][k]] != group[i]) {
                    addEdge(groupGraph, group[beforeItems[j][k]], group[i]);
                }
            }
        }
    }

    int itemOrder[MAXN], groupOrder[MAXN];
    if (!topologicalSort(itemGraph, n, itemOrder) || !topologicalSort(groupGraph, m, groupOrder)) {
        return 0;
    }

    int *result = (int *)malloc(n * sizeof(int));
    int resIndex = 0;
    for (int i = 0; i < m; i++) {
        int groupItems[MAXN], groupCount = 0;
        for (int j = 0; j < n; j++) {
            if (group[j] == groupOrder[i]) {
                groupItems[groupCount++] = j;
            }
        }

        int order[MAXN];
        if (topologicalSort(itemGraph, groupCount, order)) {
            for (int j = 0; j < groupCount; j++) {
                result[resIndex++] = groupItems[order[j]];
            }
        }
    }

    *returnSize = resIndex;
    return result;
}