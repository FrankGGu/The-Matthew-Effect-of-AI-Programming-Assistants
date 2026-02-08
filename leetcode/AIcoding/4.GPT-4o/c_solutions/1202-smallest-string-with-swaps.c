#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int parent;
} UnionFind;

int find(UnionFind *uf, int x) {
    if (uf[x].parent != x) {
        uf[x].parent = find(uf, uf[x].parent);
    }
    return uf[x].parent;
}

void unionSets(UnionFind *uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        uf[rootY].parent = rootX;
    }
}

char *smallestStringWithSwaps(char *s, int **pairs, int pairsSize, int *pairsColSize) {
    int n = strlen(s);
    UnionFind *uf = (UnionFind *)malloc(n * sizeof(UnionFind));
    for (int i = 0; i < n; i++) {
        uf[i].parent = i;
    }

    for (int i = 0; i < pairsSize; i++) {
        unionSets(uf, pairs[i][0], pairs[i][1]);
    }

    char **groups = (char **)malloc(n * sizeof(char *));
    int *groupSizes = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        if (!groups[root]) {
            groups[root] = (char *)malloc(n + 1);
            groups[root][0] = '\0';
        }
        int len = strlen(groups[root]);
        groups[root][len] = s[i];
        groups[root][len + 1] = '\0';
        groupSizes[root]++;
    }

    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        if (groupSizes[root] > 0) {
            qsort(groups[root], groupSizes[root], sizeof(char), (int (*)(const void *, const void *))strcmp);
            groupSizes[root] = 0;
        }
    }

    char *result = (char *)malloc((n + 1) * sizeof(char));
    result[n] = '\0';
    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        if (groupSizes[root] < strlen(groups[root])) {
            result[i] = groups[root][groupSizes[root]];
            groupSizes[root]++;
        } else {
            result[i] = s[i];
        }
    }

    for (int i = 0; i < n; i++) {
        free(groups[i]);
    }
    free(groups);
    free(groupSizes);
    free(uf);
    return result;
}