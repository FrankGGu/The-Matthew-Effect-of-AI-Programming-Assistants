#include <stdio.h>
#include <stdlib.h>

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        parent[rootY] = rootX;
    }
}

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

int largestComponentSize(int* A, int ASize) {
    int maxNum = 0;
    for (int i = 0; i < ASize; i++) {
        if (A[i] > maxNum) {
            maxNum = A[i];
        }
    }

    int* parent = (int*)malloc((maxNum + 1) * sizeof(int));
    for (int i = 0; i <= maxNum; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < ASize; i++) {
        for (int j = i + 1; j < ASize; j++) {
            if (gcd(A[i], A[j]) > 1) {
                unionSet(parent, A[i], A[j]);
            }
        }
    }

    int* count = (int*)calloc(maxNum + 1, sizeof(int));
    int maxSize = 0;
    for (int i = 0; i < ASize; i++) {
        int root = find(parent, A[i]);
        count[root]++;
        if (count[root] > maxSize) {
            maxSize = count[root];
        }
    }

    free(parent);
    free(count);
    return maxSize;
}