#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

#define MAX_NODES 100000

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

AdjNode* adj[MAX_NODES]; // Adjacency list for the tree
int N_nodes;             // Total number of nodes in the tree
int* Nums;               // Pointer to the input genetic values array
int* Ans;                // Pointer to the result array (smallest missing value for each subtree)
bool present_values[MAX_NODES + 2];
int subtree_size[MAX_NODES]; // Stores the size of the subtree rooted at each node
int current_mex;             // Stores the smallest missing positive integer (MEX) for the current set of values in `present_values`

void add_edge(int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = v;
    newNode->next = adj[u];
    adj[u] = newNode;
}

void dfs_size(int u) {
    subtree_size[u] = 1;
    for (AdjNode* node = adj[u]; node != NULL; node = node->next) {
        int v = node->val;
        dfs_size(v);
        subtree_size[u] += subtree_size[v];
    }
}

void add_values(int u) {
    // Only track values that are relevant for MEX (up to N_nodes + 1)
    if (Nums[u] <= N_nodes + 1) {
        present_values[Nums[u]] = true;
        // Increment current_mex until it finds a value not present
        while (present_values[current_mex]) {
            current_mex++;
        }
    }
    for (AdjNode* node = adj[u]; node != NULL; node = node->next) {
        int v = node->val;
        add_values(v);
    }
}

void remove_values(int u) {
    // Only process values that were tracked
    if (Nums[u] <= N_nodes + 1) {
        if (present_values[Nums[u]]) { // Only set to false if it was true
            present_values[Nums[u]] = false;
            // If the removed value is smaller than the current_mex, it becomes the new smallest missing
            if (Nums[u] < current_mex) {
                current_mex = Nums[u];
            }
        }
    }
    for (AdjNode* node = adj[u]; node != NULL; node = node->next) {
        int v = node->val;
        remove_values(v);
    }
}

void dfs_solve(int u, bool keep) {
    int heaviest_child = -1;
    int max_size = -1;

    // 1. Find the heaviest child (child with the largest subtree)
    for (AdjNode* node = adj[u]; node != NULL; node = node->next) {
        int v = node->val;
        if (subtree_size[v] > max_size) {
            max_size = subtree_size[v];
            heaviest_child = v;
        }
    }

    // 2. Recursively call dfs_solve for all light children
    // Their values are processed and then cleared from `present_values`
    for (AdjNode* node = adj[u]; node != NULL; node = node->next) {
        int v = node->val;
        if (v != heaviest_child) {
            dfs_solve(v, false); // Process light child, then clear its values
        }
    }

    // 3. Recursively call dfs_solve for the heaviest child
    // Its values are kept in `present_values` for efficiency
    if (heaviest_child != -1) {
        dfs_solve(heaviest_child, true); // Process heaviest child, keep its values
    }

    // 4. Add the current node's genetic value to `present_values`
    if (Nums[u] <= N_nodes + 1) {
        present_values[Nums[u]] = true;
        // Update current_mex
        while (present_values[current_mex]) {
            current_mex++;
        }
    }

    // 5. Add values from all light children subtrees (which were previously cleared)
    for (AdjNode* node = adj[u]; node != NULL; node = node->next) {
        int v = node->val;
        if (v != heaviest_child) {
            add_values(v); // Add values from light children subtrees, updating current_mex
        }
    }

    // 6. At this point, `current_mex` holds the smallest missing positive integer
    // for the entire subtree rooted at 'u'. Store it in the answer array.
    Ans[u] = current_mex;

    // 7. If 'keep' is false (meaning 'u' is a light child of its parent, or the root with `keep=false`),
    // clear all values added by this subtree (u and its children) from `present_values`.
    // This ensures that these values do not interfere with processing sibling subtrees or the parent.
    if (!keep) {
        remove_values(u);
    }
}

void free_adj_list(int u) {
    AdjNode* current = adj[u];
    while (current != NULL) {
        AdjNode* next = current->next;
        free(current);
        current = next;
    }
    adj[u] = NULL;
}

int* smallestMissingValueSubtree(int* parents, int parentsSize, int* nums, int numsSize, int* returnSize) {
    N_nodes = parentsSize;
    Nums = nums;
    *returnSize = N_nodes;
    Ans = (int*)malloc(sizeof(int) * N_nodes);

    // Initialize adjacency list pointers to NULL
    for (int i = 0; i < N_nodes; ++i) {
        adj[i] = NULL;
    }

    // Clear present_values array (global arrays are usually zero-initialized, but explicit memset is safer)
    memset(present_values, 0, sizeof(bool) * (N_nodes + 2));

    // Build adjacency list (tree structure). Node 0 is the root.
    for (int i = 1; i < N_nodes; ++i) {
        add_edge(parents[i], i);
    }

    // Calculate subtree sizes for the DSU on tree algorithm
    dfs_size(0); // Start from the root (node 0)

    // Initialize current_mex to 1 (the smallest positive integer)
    current_mex = 1;

    // Solve the problem using the DSU on tree algorithm.
    // The root (node 0) is processed. 'keep=false' is passed, but it doesn't affect correctness
    // as there's no parent to clear values for after the root's processing.
    dfs_solve(0, false);

    // Free dynamically allocated adjacency list memory to prevent leaks
    for (int i = 0; i < N_nodes; ++i) {
        free_adj_list(i);
    }

    return Ans;
}