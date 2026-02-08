#include <stdlib.h> // For malloc, realloc, free

typedef struct {
    int* neighbors;
    int size;
    int capacity;
} AdjList;

AdjList* graph_global;
int* quiet_global;
int* ans_global;
int N_global;

void init_adj_lists(int n) {
    graph_global = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; ++i) {
        graph_global[i].neighbors = NULL;
        graph_global[i].size = 0;
        graph_global[i].capacity = 0;
    }
}

void add_edge(int u, int v) {
    if (graph_global[u].size == graph_global[u].capacity) {
        graph_global[u].capacity = graph_global[u].capacity == 0 ? 2 : graph_global[u].capacity * 2;
        graph_global[u].neighbors = (int*)realloc(graph_global[u].neighbors, graph_global[u].capacity * sizeof(int));
    }
    graph_global[u].neighbors[graph_global[u].size++] = v;
}

int dfs(int u) {
    // If the result for u is already computed, return it (memoization)
    if (ans_global[u] != -1) {
        return ans_global[u];
    }

    // Initialize the current quietest person to u itself
    int min_quiet_person_idx = u;

    // Iterate through all people 'v' that are richer than 'u'
    for (int i = 0; i < graph_global[u].size; ++i) {
        int v = graph_global[u].neighbors[i]; // v is richer than u

        // Recursively find the quietest person among v and those richer than v
        int richer_min_quiet_person_idx = dfs(v);

        // Compare the quietness of the current best candidate with the one found through v
        if (quiet_global[richer_min_quiet_person_idx] < quiet_global[min_quiet_person_idx]) {
            min_quiet_person_idx = richer_min_quiet_person_idx;
        }
    }

    // Store the computed result for u and return it
    ans_global[u] = min_quiet_person_idx;
    return min_quiet_person_idx;
}

int* loudAndRich(int** richer, int richerSize, int* richerColSize, int* quiet, int quietSize, int* returnSize) {
    N_global = quietSize;
    quiet_global = quiet;

    // Initialize adjacency lists for all people
    init_adj_lists(N_global);

    // Build the graph: For richer[i] = [ai, bi], it means ai is richer than bi.
    // We want to find for each person 'p', the quietest person 'q' such that 'q' is richer than 'p' (or q==p).
    // This implies we need to traverse from 'p' upwards to its richer ancestors.
    // So, if ai is richer than bi, we add an edge from bi to ai (meaning ai is an ancestor of bi).
    for (int i = 0; i < richerSize; ++i) {
        int richer_person = richer[i][0];
        int poorer_person = richer[i][1];
        add_edge(poorer_person, richer_person);
    }

    // Allocate memory for the answer array and initialize with -1 (uncomputed)
    ans_global = (int*)malloc(N_global * sizeof(int));
    for (int i = 0; i < N_global; ++i) {
        ans_global[i] = -1;
    }

    // Run DFS for each person to compute their quietest richer person
    for (int i = 0; i < N_global; ++i) {
        dfs(i);
    }

    // Free memory used by adjacency lists
    for (int i = 0; i < N_global; ++i) {
        if (graph_global[i].neighbors != NULL) {
            free(graph_global[i].neighbors);
        }
    }
    free(graph_global); // Free the array of AdjList structures

    *returnSize = N_global;
    return ans_global; // Return the computed results
}