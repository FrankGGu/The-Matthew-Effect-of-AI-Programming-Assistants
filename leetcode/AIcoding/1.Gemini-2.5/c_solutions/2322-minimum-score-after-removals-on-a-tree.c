#include <stdlib.h>
#include <limits.h>

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

static int* subtree_xor_sums;
static int* parent_nodes;
static int* tin_times; // Entry time for DFS
static int* tout_times; // Exit time for DFS
static int timer; // Global timer for tin/tout

void add_edge(AdjNode** adj_heads, int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = v;
    newNode->next = adj_heads[u];
    adj_heads[u] = newNode;
}

void dfs(int u, int p, int* nums, AdjNode** adj_heads) {
    parent_nodes[u] = p;
    tin_times[u] = timer++;
    subtree_xor_sums[u] = nums[u];

    AdjNode* current = adj_heads[u];
    while (current != NULL) {
        int v = current->val;
        if (v != p) { // Avoid going back to parent
            dfs(v, u, nums, adj_heads);
            subtree_xor_sums[u] ^= subtree_xor_sums[v]; // Accumulate child's subtree XOR sum
        }
        current = current->next;
    }
    tout_times[u] = timer++;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minimumScore(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = numsSize;

    // Allocate memory for global arrays
    subtree_xor_sums = (int*)malloc(n * sizeof(int));
    parent_nodes = (int*)malloc(n * sizeof(int));
    tin_times = (int*)malloc(n * sizeof(int));
    tout_times = (int*)malloc(n * sizeof(int));

    // Build adjacency list
    AdjNode** adj_heads = (AdjNode**)calloc(n, sizeof(AdjNode*)); // Initialize with NULL
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(adj_heads, u, v);
        add_edge(adj_heads, v, u);
    }

    timer = 0;
    // Start DFS from root (node 0), with a dummy parent -1
    dfs(0, -1, nums, adj_heads); 

    // The total XOR sum of the entire tree is the XOR sum of the root's subtree
    int total_tree_xor_sum = subtree_xor_sums[0];
    int min_score = INT_MAX;

    // Iterate over all distinct pairs of edges to remove.
    // An edge is uniquely identified by its child node `v` (since parent[v] is unique).
    // We iterate `v1` from 1 to n-1 and `v2` from `v1 + 1` to n-1.
    // This implicitly selects edges (parent[v1], v1) and (parent[v2], v2).
    for (int v1 = 1; v1 < n; ++v1) {
        for (int v2 = v1 + 1; v2 < n; ++v2) {
            int x1, x2, x3;

            // Check if v1 is an ancestor of v2 (v2 is in subtree of v1)
            int v1_is_ancestor_of_v2 = (tin_times[v1] < tin_times[v2] && tout_times[v2] < tout_times[v1]);
            // Check if v2 is an ancestor of v1 (v1 is in subtree of v2)
            int v2_is_ancestor_of_v1 = (tin_times[v2] < tin_times[v1] && tout_times[v1] < tout_times[v2]);

            if (v1_is_ancestor_of_v2) {
                // Case 1: v2 is in the subtree of v1.
                // Removing edge (parent[v1], v1) and (parent[v2], v2) results in:
                // Component 1: subtree rooted at v2. XOR sum = subtree_xor_sums[v2]
                // Component 2: part of subtree rooted at v1, excluding subtree rooted at v2. XOR sum = subtree_xor_sums[v1] ^ subtree_xor_sums[v2]
                // Component 3: the rest of the tree (original tree - subtree rooted at v1). XOR sum = total_tree_xor_sum ^ subtree_xor_sums[v1]
                x1 = subtree_xor_sums[v2];
                x2 = subtree_xor_sums[v1] ^ subtree_xor_sums[v2];
                x3 = total_tree_xor_sum ^ subtree_xor_sums[v1];
            } else if (v2_is_ancestor_of_v1) {
                // Case 2: v1 is in the subtree of v2. (Symmetric to Case 1)
                x1 = subtree_xor_sums[v1];
                x2 = subtree_xor_sums[v2] ^ subtree_xor_sums[v1];
                x3 = total_tree_xor_sum ^ subtree_xor_sums[v2];
            } else {
                // Case 3: v1 and v2 are in independent subtrees (neither is an ancestor of the other).
                // Removing edge (parent[v1], v1) and (parent[v2], v2) results in:
                // Component 1: subtree rooted at v1. XOR sum = subtree_xor_sums[v1]
                // Component 2: subtree rooted at v2. XOR sum = subtree_xor_sums[v2]
                // Component 3: the rest of the tree (original tree - subtree rooted at v1 - subtree rooted at v2). XOR sum = total_tree_xor_sum ^ subtree_xor_sums[v1] ^ subtree_xor_sums[v2]
                x1 = subtree_xor_sums[v1];
                x2 = subtree_xor_sums[v2];
                x3 = total_tree_xor_sum ^ subtree_xor_sums[v1] ^ subtree_xor_sums[v2];
            }

            int current_max = max(x1, max(x2, x3));
            int current_min = min(x1, min(x2, x3));
            min_score = min(min_score, current_max - current_min);
        }
    }

    // Free allocated memory
    free(subtree_xor_sums);
    free(parent_nodes);
    free(tin_times);
    free(tout_times);

    // Free adjacency list memory
    for (int i = 0; i < n; ++i) {
        AdjNode* current = adj_heads[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj_heads);

    return min_score;
}