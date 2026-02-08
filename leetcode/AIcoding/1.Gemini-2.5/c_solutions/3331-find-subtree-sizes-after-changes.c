#include <stdlib.h>
#include <string.h>

#define MAXN 200005 // Maximum number of nodes + a small buffer

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

AdjNode* adj[MAXN]; // Adjacency list for the tree
int tin[MAXN];       // Entry time in DFS traversal
int tout[MAXN];      // Exit time in DFS traversal (or last DFS order index of subtree)
int timer;           // Global timer for DFS traversal
int node_status[MAXN]; // 0 for inactive, 1 for active
int bit[MAXN];       // Fenwick tree (Binary Indexed Tree) for active node counts
int N_nodes_global;  // Total number of nodes, used for BIT bounds

void update_bit(int idx, int delta) {
    for (; idx <= N_nodes_global; idx += idx & -idx) {
        bit[idx] += delta;
    }
}

int query_bit(int idx) {
    int sum = 0;
    for (; idx > 0; idx -= idx & -idx) {
        sum += bit[idx];
    }
    return sum;
}

void dfs(int u, int p) {
    tin[u] = ++timer; // Assign entry time

    // If the node is initially active, add it to the Fenwick Tree at its entry time
    if (node_status[u] == 1) {
        update_bit(tin[u], 1);
    }

    AdjNode* curr = adj[u];
    while (curr != NULL) {
        int v = curr->val;
        if (v != p) {
            dfs(v, u);
        }
        curr = curr->next;
    }
    tout[u] = timer; // Assign exit time (the last DFS order index covered by this subtree)
}

void add_edge(int u, int v) {
    AdjNode* newNode1 = (AdjNode*)malloc(sizeof(AdjNode));
    newNode1->val = v;
    newNode1->next = adj[u];
    adj[u] = newNode1;

    AdjNode* newNode2 = (AdjNode*)malloc(sizeof(AdjNode));
    newNode2->val = u;
    newNode2->next = adj[v];
    adj[v] = newNode2;
}

int* findSubtreeSizesAfterChanges(int n, int** edges, int edgesSize, int* edgesColSize, int* initial_status, int initial_statusSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    N_nodes_global = n; // Set global node count for BIT operations

    // Initialize data structures
    for (int i = 0; i <= n; ++i) {
        adj[i] = NULL;
        node_status[i] = 0; // Default to inactive
        tin[i] = 0;
        tout[i] = 0;
    }
    timer = 0;
    memset(bit, 0, sizeof(int) * (n + 1)); // Clear Fenwick tree

    // Build the adjacency list from the given edges
    for (int i = 0; i < edgesSize; ++i) {
        add_edge(edges[i][0], edges[i][1]);
    }

    // Set initial node statuses (adjusting for 0-indexed initial_status array to 1-indexed nodes)
    for (int i = 0; i < initial_statusSize; ++i) {
        node_status[i + 1] = initial_status[i];
    }

    // Perform DFS starting from root (assuming node 1 is the root, parent 0)
    // This populates tin/tout arrays and initializes the BIT based on initial statuses.
    dfs(1, 0);

    // Allocate memory for answers and initialize returnSize
    int* answers = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = 0;

    // Process each query
    for (int i = 0; i < queriesSize; ++i) {
        int type = queries[i][0];
        int node_id = queries[i][1];

        if (type == 0) { // Toggle node status query
            if (node_status[node_id] == 1) { // Node was active, now becomes inactive
                update_bit(tin[node_id], -1); // Decrement count in BIT
                node_status[node_id] = 0;
            } else { // Node was inactive, now becomes active
                update_bit(tin[node_id], 1);  // Increment count in BIT
                node_status[node_id] = 1;
            }
        } else if (type == 1) { // Query subtree size (number of active nodes)
            // The sum of active nodes in a subtree is the sum in BIT from tin[node_id] to tout[node_id]
            int active_nodes_in_subtree = query_bit(tout[node_id]) - query_bit(tin[node_id] - 1);
            answers[(*returnSize)++] = active_nodes_in_subtree;
        }
    }

    // Free memory allocated for adjacency list
    for (int i = 0; i <= n; ++i) {
        AdjNode* curr = adj[i];
        while (curr != NULL) {
            AdjNode* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }

    return answers;
}