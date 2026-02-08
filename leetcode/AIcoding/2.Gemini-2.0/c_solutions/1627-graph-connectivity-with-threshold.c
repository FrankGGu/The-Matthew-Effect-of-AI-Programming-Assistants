#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int size[], int a, int b) {
    a = find(parent, a);
    b = find(parent, b);
    if (a != b) {
        if (size[a] < size[b]) {
            int temp = a;
            a = b;
            b = temp;
        }
        parent[b] = a;
        size[a] += size[b];
    }
}

bool* areConnected(int n, int threshold, int** queries, int queriesSize, int* queriesColSize) {
    int parent[n + 1];
    int size[n + 1];
    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        size[i] = 1;
    }

    for (int i = threshold + 1; i <= n; i++) {
        for (int j = 2 * i; j <= n; j += i) {
            unite(parent, size, i, j);
        }
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = (find(parent, queries[i][0]) == find(parent, queries[i][1]));
    }

    return result;
}