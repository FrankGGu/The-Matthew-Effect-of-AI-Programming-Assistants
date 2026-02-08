#include <stdlib.h> // For malloc, free
#include <string.h> // For memset (though not strictly needed here)

typedef struct EdgeNode {
    int to;
    struct EdgeNode* next;
} EdgeNode;

int N_nodes_global;
EdgeNode** adj_global; // Adjacency list
long long* count_nodes_global; // Stores count of nodes in subtree
long long* dist_sum_subtree_global; // Stores sum of distances from root to nodes in its subtree
long long* ans_final_global; // Stores final answer for each node

void add_edge_global(int u, int v) {
    EdgeNode* newNode1 = (EdgeNode*)malloc(sizeof(EdgeNode));
    newNode1->to = v;
    newNode1->next = adj_global[u];
    adj_global[u] = newNode1;

    EdgeNode* newNode2 = (EdgeNode*)malloc(sizeof(EdgeNode));
    newNode2->to = u;
    newNode2->next = adj_global[v];
    adj_global[v] = newNode2;
}

void dfs1_global(int u, int parent) {
    count_nodes_global[u] = 1;
    dist_sum_subtree_global[u] = 0;

    EdgeNode* current = adj_global[u];
    while (current != NULL) {
        int v = current->to;
        if (v == parent) {
            current = current->next;
            continue;
        }
        dfs1_global(v, u);
        count_nodes_global[u] += count_nodes_global[v];
        dist_sum_subtree_global[u] += dist_sum_subtree_global[v] + count_nodes_global[v];
        current = current->next;
    }
}

void dfs2_global(int u, int parent) {
    EdgeNode* current = adj_global[u];
    while (current != NULL) {
        int v = current->to;
        if (v == parent) {
            current = current->next;
            continue;
        }
        // When moving from parent u to child v:
        // Nodes in v's subtree (count_nodes_global[v]) become 1 unit closer to v.
        // Nodes NOT in v's subtree (N_nodes_global - count_nodes_global[v]) become 1 unit farther from v.
        ans_final_global[v] = ans_final_global[u] - count_nodes_global[v] + (N_nodes_global - count_nodes_global[v]);
        dfs2_global(v, u);
        current = current->next;
    }
}

long long* sumOfDistancesInTree(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    N_nodes_global = n;

    // Initialize adjacency list
    adj_global = (EdgeNode**)malloc(N_nodes_global * sizeof(EdgeNode*));
    for (int i = 0; i < N_nodes_global; ++i) {
        adj_global[i] = NULL;
    }

    // Build adjacency list from input edges
    for (int i = 0; i < edgesSize; ++i) {
        add_edge_global(edges[i][0], edges[i][1]);
    }

    // Allocate memory for global arrays
    count_nodes_global = (long long*)malloc(N_nodes_global * sizeof(long long));
    dist_sum_subtree_global = (long long*)malloc(N_nodes_global * sizeof(long long));
    ans_final_global = (long long*)malloc(N_nodes_global * sizeof(long long));

    // Perform DFS1 starting from node 0 (arbitrary root), with -1 as its parent
    dfs1_global(0, -1);

    // Initialize the answer for the root node (node 0) using the result from DFS1
    ans_final_global[0] = dist_sum_subtree_global[0];

    // Perform DFS2 starting from node 0, propagating results down the tree
    dfs2_global(0, -1);

    *returnSize = N_nodes_global;

    // Clean up dynamically allocated memory for adjacency list, count_nodes, and dist_sum_subtree
    for (int i = 0; i < N_nodes_global; ++i) {
        EdgeNode* current = adj_global[i];
        while (current != NULL) {
            EdgeNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj_global);
    free(count_nodes_global);
    free(dist_sum_subtree_global);

    // Return the final answer array; caller is responsible for freeing it
    return ans_final_global;
}