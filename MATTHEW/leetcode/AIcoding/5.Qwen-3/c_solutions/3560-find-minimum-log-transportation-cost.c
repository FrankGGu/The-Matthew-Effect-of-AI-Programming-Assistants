#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCostToSupplyWater(int* wells, int wellsSize, int** pipes, int pipesSize, int* pipesColSize) {
    int n = wellsSize;
    int totalNodes = n + 1;
    int* parent = (int*)malloc((totalNodes) * sizeof(int));
    for (int i = 0; i < totalNodes; i++) {
        parent[i] = i;
    }

    int* rank = (int*)malloc((totalNodes) * sizeof(int));

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootX] = rootY;
                if (rank[rootX] == rank[rootY]) {
                    rank[rootY]++;
                }
            }
        }
    }

    int** edges = (int**)malloc((pipesSize + n) * sizeof(int*));
    for (int i = 0; i < pipesSize; i++) {
        edges[i] = (int*)malloc(3 * sizeof(int));
        edges[i][0] = pipes[i][0];
        edges[i][1] = pipes[i][1];
        edges[i][2] = pipes[i][2];
    }

    for (int i = 0; i < n; i++) {
        edges[pipesSize + i] = (int*)malloc(3 * sizeof(int));
        edges[pipesSize + i][0] = 0;
        edges[pipesSize + i][1] = i + 1;
        edges[pipesSize + i][2] = wells[i];
    }

    qsort(edges, pipesSize + n, sizeof(int*), compare);

    int cost = 0;
    for (int i = 0; i < pipesSize + n; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        if (find(u) != find(v)) {
            unionSet(u, v);
            cost += w;
        }
    }

    free(parent);
    free(rank);
    for (int i = 0; i < pipesSize + n; i++) {
        free(edges[i]);
    }
    free(edges);

    return cost;
}