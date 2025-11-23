#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MOD 1000000007

typedef struct {
    int* parent;
    int* sz; // size of the component
    long long* edges; // number of internal edges within the component
    bool* is_infected; // true if any node in the component is infected
    int n;
} DSU;

void dsu_init(DSU* dsu, int n_nodes) {
    dsu->n = n_nodes;
    dsu->parent = (int*)malloc(n_nodes * sizeof(int));
    dsu->sz = (int*)malloc(n_nodes * sizeof(int));
    dsu->edges = (long long*)malloc(n_nodes * sizeof(long long));
    dsu->is_infected = (bool*)malloc(n_nodes * sizeof(bool));

    for (int i = 0; i < n_nodes; ++i) {
        dsu->parent[i] = i;
        dsu->sz[i] = 1;
        dsu->edges[i] = 0;
        dsu->is_infected[i] = false;
    }
}

void dsu_free(DSU* dsu) {
    free(dsu->parent);
    free(dsu->sz);
    free(dsu->edges);
    free(dsu->is_infected);
}

int dsu_find(DSU* dsu, int i) {
    if (dsu->parent[i] == i) {
        return i;
    }
    return dsu->parent[i] = dsu_find(dsu, dsu->parent[i]);
}

void dsu_unite(DSU* dsu, int u, int v, long long* ans, int* total_infected_nodes) {
    int ru = dsu_find(dsu, u);
    int rv = dsu_find(dsu, v);

    if (ru == rv) {
        // Meeting within the same component. It adds an internal edge.
        // This edge forms a cycle. The factor is `edges[ru] + 1`.
        *ans = (*ans * (dsu->edges[ru] + 1)) % MOD;
        dsu->edges[ru]++;
    } else {
        // Ensure that if one component is infected, its root becomes the new root.
        // If both are infected, or neither, it doesn't matter which becomes the root.
        if (dsu->is_infected[rv] && !dsu->is_infected[ru]) {
            // Swap ru and rv so ru is the infected one (or the one we prefer to keep as root)
            int temp = ru;
            ru = rv;
            rv = temp;
        }
        // Now, if any component was infected, ru is its root.

        bool u_was_infected = dsu->is_infected[ru];
        bool v_was_infected = dsu->is_infected[rv]; // This refers to the original rv's infection status

        // Store original size of rv's component before merging for calculation
        int original_rv_size = dsu->sz[rv];

        // Merge rv into ru
        dsu->parent[rv] = ru;
        dsu->sz[ru] += dsu->sz[rv];
        dsu->edges[ru] += dsu->edges[rv] + 1; // Add new edge and existing edges from rv's component

        if (u_was_infected && v_was_infected) {
            // Both components were infected.
            // Factor for adding the edge: `edges[ru]` (new total edges in ru's component)
            *ans = (*ans * dsu->edges[ru]) % MOD;
            // is_infected[ru] remains true.
        } else if (u_was_infected || v_was_infected) {
            // One component was infected, the other was not. This meeting spreads infection.
            // The uninfected component's size was `original_rv_size`.
            // Factor for infecting `uninfected_root` component: `original_rv_size`.
            *ans = (*ans * original_rv_size) % MOD; 
            *total_infected_nodes += original_rv_size;

            // Factor for adding the edge: `edges[ru]` (new total edges in ru's component)
            *ans = (*ans * dsu->edges[ru]) % MOD;
            dsu->is_infected[ru] = true; // The combined component is now infected.
        } else {
            // Neither component was infected.
            // Factor for adding the edge: `edges[ru]` (new total edges in ru's component)
            *ans = (*ans * dsu->edges[ru]) % MOD;
            // is_infected[ru] remains false.
        }
    }
}

int countTheNumOfInfectionSequences(int n, int** meetings, int meetingsSize, int* meetingsColSize) {
    DSU dsu;
    dsu_init(&dsu, n);

    long long ans = 1;
    int total_infected_nodes = 1; // Person 0 is initially infected

    dsu.is_infected[dsu_find(&dsu, 0)] = true;

    for (int i = 0; i < meetingsSize; ++i) {
        int u = meetings[i][0];
        int v = meetings[i][1];
        dsu_unite(&dsu, u, v, &ans, &total_infected_nodes);
    }

    dsu_free(&dsu);

    if (total_infected_nodes != n) {
        return 0;
    }

    return (int)ans;
}