#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int value;
    int parent;
    int rank;
} UnionFind;

int find(UnionFind* uf, int x) {
    if (uf[x].parent != x) {
        uf[x].parent = find(uf, uf[x].parent);
    }
    return uf[x].parent;
}

void unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf[rootX].rank > uf[rootY].rank) {
            uf[rootY].parent = rootX;
        } else {
            uf[rootX].parent = rootY;
            if (uf[rootX].rank == uf[rootY].rank) {
                uf[rootY].rank++;
            }
        }
    }
}

long long maximumSegmentSum(int* nums, int numsSize, int* removeQueries, int removeQueriesSize) {
    int n = numsSize;
    UnionFind* uf = (UnionFind*)malloc((n + 1) * sizeof(UnionFind));
    for (int i = 0; i <= n; i++) {
        uf[i].parent = i;
        uf[i].rank = 0;
        uf[i].value = 0;
    }

    for (int i = 0; i < n; i++) {
        uf[i].value = nums[i];
    }

    long long maxSum = 0;
    long long* result = (long long*)malloc(removeQueriesSize * sizeof(long long));
    int* removed = (int*)calloc(n, sizeof(int));

    for (int i = removeQueriesSize - 1; i >= 0; i--) {
        int q = removeQueries[i];
        removed[q] = 1;
        uf[q].value = nums[q];

        if (q > 0 && removed[q - 1]) {
            unionSet(uf, q, q - 1);
        }
        if (q < n - 1 && removed[q + 1]) {
            unionSet(uf, q, q + 1);
        }

        int root = find(uf, q);
        long long sum = 0;
        for (int j = 0; j < n; j++) {
            if (find(uf, j) == root) {
                sum += uf[j].value;
            }
        }
        maxSum = (sum > maxSum) ? sum : maxSum;
        result[i] = maxSum;
    }

    for (int i = 0; i < removeQueriesSize; i++) {
        result[i] = result[removeQueriesSize - 1 - i];
    }

    long long* answer = (long long*)malloc(removeQueriesSize * sizeof(long long));
    for (int i = 0; i < removeQueriesSize; i++) {
        answer[i] = result[i];
    }

    free(removed);
    free(result);
    free(uf);

    return answer[0];
}