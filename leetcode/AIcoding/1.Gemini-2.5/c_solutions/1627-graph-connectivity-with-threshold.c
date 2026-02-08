#include <stdbool.h>
#include <stdlib.h> // For malloc, free

int* parent;
int* sz; // size for union by size optimization

void init_dsu(int n) {
    parent = (int*)malloc(sizeof(int) * (n + 1));
    sz = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; ++i) {
        parent[i] = i;
        sz[i] = 1;
    }
}

int find_set(int v) {
    if (v == parent[v])
        return v;
    return parent[v] = find_set(parent[v]);
}

void union_sets(int a, int b) {
    a = find_set(a);
    b = find_set(b);
    if (a != b) {
        if (sz[a] < sz[b]) {
            int temp = a;
            a = b;
            b = temp;
        }
        parent[b] = a;
        sz[a] += sz[b];
    }
}

bool* areConnected(int n, int threshold, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    init_dsu(n);

    for (int g = threshold + 1; g <= n; ++g) {
        for (int multiple = 2 * g; multiple <= n; multiple += g) {
            union_sets(g, multiple);
        }
    }

    bool* result = (bool*)malloc(sizeof(bool) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; ++i) {
        int u = queries[i][0];
        int v = queries[i][1];

        result[i] = (find_set(u) == find_set(v));
    }

    free(parent);
    free(sz);

    return result;
}