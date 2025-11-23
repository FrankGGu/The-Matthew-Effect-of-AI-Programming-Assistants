#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* parent;
    int* rank;
    int components;
} DSU;

void dsu_init(DSU* dsu, int n) {
    dsu->parent = (int*)malloc((n + 1) * sizeof(int));
    dsu->rank = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 1; i <= n; ++i) {
        dsu->parent[i] = i;
        dsu->rank[i] = 0;
    }
    dsu->components = n;
}

void dsu_free(DSU* dsu) {
    free(dsu->parent);
    free(dsu->rank);
}

int dsu_find(DSU* dsu, int i) {
    if (dsu->parent[i] == i) {
        return i;
    }
    return dsu->parent[i] = dsu_find(dsu, dsu->parent[i]);
}

bool dsu_unite(DSU* dsu, int i, int j) {
    int root_i = dsu_find(dsu, i);
    int root_j = dsu_find(dsu, j);

    if (root_i != root_j) {
        if (dsu->rank[root_i] < dsu->rank[root_j]) {
            dsu->parent[root_i] = root_j;
        } else if (dsu->rank[root_i] > dsu->rank[root_j]) {
            dsu->parent[root_j] = root_i;
        } else {
            dsu->parent[root_j] = root_i;
            dsu->rank[root_i]++;
        }
        dsu->components--;
        return true;
    }
    return false;
}

int maxNumEdgesToRemove(int n, int** edges, int edgesSize, int* edgesColSize) {
    DSU alice_dsu, bob_dsu;
    dsu_init(&alice_dsu, n);
    dsu_init(&bob_dsu, n);

    int edges_kept = 0;

    for (int i = 0; i < edgesSize; ++i) {
        if (edges[i][0] == 3) {
            int u = edges[i][1];
            int v = edges[i][2];
            if (dsu_unite(&alice_dsu, u, v) | dsu_unite(&bob_dsu, u, v)) {
                edges_kept++;
            }
        }
    }

    for (int i = 0; i < edgesSize; ++i) {
        if (edges[i][0] == 1) {
            int u = edges[i][1];
            int v = edges[i][2];
            if (dsu_unite(&alice_dsu, u, v)) {
                edges_kept++;
            }
        }
    }

    for (int i = 0; i < edgesSize; ++i) {
        if (edges[i][0] == 2) {
            int u = edges[i][1];
            int v = edges[i][2];
            if (dsu_unite(&bob_dsu, u, v)) {
                edges_kept++;
            }
        }
    }

    if (alice_dsu.components != 1 || bob_dsu.components != 1) {
        dsu_free(&alice_dsu);
        dsu_free(&bob_dsu);
        return -1;
    }

    int removed_edges = edgesSize - edges_kept;

    dsu_free(&alice_dsu);
    dsu_free(&bob_dsu);

    return removed_edges;
}