#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int* parent;
    int* rank;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else {
            uf->parent[rootX] = rootY;
            if (uf->rank[rootX] == uf->rank[rootY]) {
                uf->rank[rootY]++;
            }
        }
    }
}

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool canSortArray(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    UnionFind* uf = createUnionFind(maxNum + 1);

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int j = 2; j <= sqrt(num); j++) {
            if (num % j == 0) {
                unionSet(uf, num, j);
                if (num / j != j) {
                    unionSet(uf, num, num / j);
                }
            }
        }
    }

    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), (int(*)(const void*, const void*))strcmp);

    for (int i = 0; i < numsSize; i++) {
        int root1 = find(uf, nums[i]);
        int root2 = find(uf, sorted[i]);
        if (root1 != root2) {
            free(uf->parent);
            free(uf->rank);
            free(uf);
            free(sorted);
            return false;
        }
    }

    free(uf->parent);
    free(uf->rank);
    free(uf);
    free(sorted);
    return true;
}