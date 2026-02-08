#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int *parent, int *rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
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

int isSimilar(char *s, char *t) {
    int diff = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] != t[i]) {
            diff++;
            if (diff > 2) return 0;
        }
    }
    return diff == 2;
}

int numSimilarGroups(char **strs, int strsSize) {
    int n = strsSize;
    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 1;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (isSimilar(strs[i], strs[j])) {
                unionSet(parent, rank, i, j);
            }
        }
    }

    int groups = 0;
    for (int i = 0; i < n; i++) {
        if (find(parent, i) == i) {
            groups++;
        }
    }

    free(parent);
    free(rank);
    return groups;
}