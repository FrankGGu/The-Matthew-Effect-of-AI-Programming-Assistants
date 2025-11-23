#include <stdlib.h>
#include <string.h>

typedef struct {
    int* parent;
    int* rank;
    int n;
} DSU;

void dsu_init(DSU* dsu, int n) {
    dsu->n = n;
    dsu->parent = (int*)malloc(n * sizeof(int));
    dsu->rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        dsu->parent[i] = i;
        dsu->rank[i] = 0;
    }
}

void dsu_free(DSU* dsu) {
    free(dsu->parent);
    free(dsu->rank);
}

int find_set(DSU* dsu, int v) {
    if (v == dsu->parent[v])
        return v;
    return dsu->parent[v] = find_set(dsu, dsu->parent[v]);
}

void union_sets(DSU* dsu, int a, int b) {
    a = find_set(dsu, a);
    b = find_set(dsu, b);
    if (a != b) {
        if (dsu->rank[a] < dsu->rank[b]) {
            int temp = a;
            a = b;
            b = temp;
        }
        dsu->parent[b] = a;
        if (dsu->rank[a] == dsu->rank[b])
            dsu->rank[a]++;
    }
}

int* minimumCost(int n, int** edges, int edgesSize, int* edgesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;
    int* ans = (int*)malloc(queriesSize * sizeof(int));

    DSU general_dsu;
    dsu_init(&general_dsu, n);
    for (int i = 0; i < edgesSize; ++i) {
        union_sets(&general_dsu, edges[i][0], edges[i][1]);
    }

    for (int i = 0; i < queriesSize; ++i) {
        int start = queries[i][0];
        int end = queries[i][1];
        if (start == end) {
            ans[i] = 0;
        } else if (find_set(&general_dsu, start) != find_set(&general_dsu, end)) {
            ans[i] = -1;
        } else {
            ans[i] = 0;
        }
    }
    dsu_free(&general_dsu);

    for (int b = 0; b < 30; ++b) {
        DSU bit_dsu;
        dsu_init(&bit_dsu, n);

        for (int i = 0; i < edgesSize; ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];
            if ((w >> b) & 1) {
                union_sets(&bit_dsu, u, v);
            }
        }

        for (int i = 0; i < queriesSize; ++i) {
            if (ans[i] == -1 || queries[i][0] == queries[i][1]) {
                continue;
            }

            int start = queries[i][0];
            int end = queries[i][1];
            if (find_set(&bit_dsu, start) == find_set(&bit_dsu, end)) {
                ans[i] |= (1 << b);
            }
        }
        dsu_free(&bit_dsu);
    }

    return ans;
}