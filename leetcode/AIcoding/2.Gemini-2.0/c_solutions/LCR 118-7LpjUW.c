#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int *parent, int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void union_sets(int *parent, int *rank, int a, int b) {
    a = find(parent, a);
    b = find(parent, b);
    if (a != b) {
        if (rank[a] < rank[b])
            {
                int temp = a;
                a = b;
                b = temp;
            }
        parent[b] = a;
        if (rank[a] == rank[b])
            rank[a]++;
    }
}

int* findRedundantConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize){
    int n = edgesSize;
    int *parent = (int *)malloc(sizeof(int) * (n + 1));
    int *rank = (int *)malloc(sizeof(int) * (n + 1));
    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (find(parent, u) == find(parent, v)) {
            result[0] = u;
            result[1] = v;
            return result;
        }
        union_sets(parent, rank, u, v);
    }

    return result;
}