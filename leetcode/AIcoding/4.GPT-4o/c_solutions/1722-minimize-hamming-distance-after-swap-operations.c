#include <stdio.h>
#include <stdlib.h>

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int *parent, int *rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int minimizeHammingDistance(int* source, int sourceSize, int* target, int targetSize, int** allowedSwaps, int allowedSwapsSize, int* allowedSwapsColSize) {
    int *parent = (int*)malloc(sourceSize * sizeof(int));
    int *rank = (int*)calloc(sourceSize, sizeof(int));
    for (int i = 0; i < sourceSize; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < allowedSwapsSize; i++) {
        unionSets(parent, rank, allowedSwaps[i][0], allowedSwaps[i][1]);
    }

    int *group[1000] = {0};
    int groupCount[1000] = {0};

    for (int i = 0; i < sourceSize; i++) {
        int root = find(parent, i);
        if (!group[root]) {
            group[root] = (int*)malloc(sourceSize * sizeof(int));
        }
        group[root][groupCount[root]++] = source[i];
    }

    for (int i = 0; i < targetSize; i++) {
        int root = find(parent, i);
        if (group[root]) {
            group[root][groupCount[root]++] = target[i];
        }
    }

    int result = 0;
    for (int i = 0; i < sourceSize; i++) {
        if (group[find(parent, i)]) {
            for (int j = 0; j < groupCount[find(parent, i)]; j++) {
                if (group[find(parent, i)][j] == target[i]) {
                    result++;
                    break;
                }
            }
        }
    }

    free(parent);
    free(rank);
    for (int i = 0; i < 1000; i++) {
        free(group[i]);
    }

    return sourceSize - result;
}