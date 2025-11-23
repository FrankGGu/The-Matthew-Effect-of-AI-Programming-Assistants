#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct DSU {
    int *parent;
    int *rank;
} DSU;

DSU* createDSU(int n) {
    DSU* dsu = (DSU*)malloc(sizeof(DSU));
    dsu->parent = (int*)malloc(sizeof(int) * n);
    dsu->rank = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        dsu->parent[i] = i;
        dsu->rank[i] = 0;
    }
    return dsu;
}

int find(DSU* dsu, int x) {
    if (dsu->parent[x] != x) {
        dsu->parent[x] = find(dsu, dsu->parent[x]);
    }
    return dsu->parent[x];
}

void unite(DSU* dsu, int x, int y) {
    int rootX = find(dsu, x);
    int rootY = find(dsu, y);
    if (rootX != rootY) {
        if (dsu->rank[rootX] < dsu->rank[rootY]) {
            dsu->parent[rootX] = rootY;
        } else if (dsu->rank[rootX] > dsu->rank[rootY]) {
            dsu->parent[rootY] = rootX;
        } else {
            dsu->parent[rootY] = rootX;
            dsu->rank[rootX]++;
        }
    }
}

char * smallestStringWithSwaps(char * s, int** pairs, int pairsSize, int* pairsColSize){
    int n = strlen(s);
    DSU* dsu = createDSU(n);

    for (int i = 0; i < pairsSize; i++) {
        unite(dsu, pairs[i][0], pairs[i][1]);
    }

    char** components = (char**)malloc(sizeof(char*) * n);
    int* componentSizes = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        components[i] = (char*)malloc(sizeof(char) * (n + 1));
        components[i][0] = '\0';
        componentSizes[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int root = find(dsu, i);
        components[root][componentSizes[root]++] = s[i];
        components[root][componentSizes[root]] = '\0';
    }

    for (int i = 0; i < n; i++) {
        if (componentSizes[i] > 0) {
            qsort(components[i], componentSizes[i], sizeof(char), (int (*)(const void *,const void *))strcmp);
        }
    }

    char* result = (char*)malloc(sizeof(char) * (n + 1));
    result[n] = '\0';
    int* componentIndices = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        componentIndices[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        int root = find(dsu, i);
        result[i] = components[root][componentIndices[root]++];
    }

    for (int i = 0; i < n; i++) {
        free(components[i]);
    }
    free(components);
    free(componentSizes);
    free(componentIndices);
    free(dsu->parent);
    free(dsu->rank);
    free(dsu);

    return result;
}