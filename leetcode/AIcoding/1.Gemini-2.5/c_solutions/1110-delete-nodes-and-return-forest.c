#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool g_is_deleted[1001];

struct TreeNode* dfs(struct TreeNode* node, bool parent_was_kept,
                     struct TreeNode*** forest_roots, int* forest_count) {
    if (node == NULL) {
        return NULL;
    }

    bool current_node_is_deleted = g_is_deleted[node->val];

    // Recursively process left and right children
    // If current node is deleted, its children's parent_was_kept becomes false.
    // Otherwise, it remains true.
    node->left = dfs(node->left, !current_node_is_deleted, forest_roots, forest_count);
    node->right = dfs(node->right, !current_node_is_deleted, forest_roots, forest_count);

    if (current_node_is_deleted) {
        // If the current node is marked for deletion, it is removed from its parent.
        // Its children (if not deleted) might become new roots, which is handled
        // by their respective DFS calls when parent_was_kept is false.
        return NULL;
    } else {
        // If the current node is NOT deleted:
        // If its parent WAS deleted (or it's the original root), then this node
        // becomes a new root of a forest tree.
        if (!parent_was_kept) {
            (*forest_roots)[(*forest_count)++] = node;
        }
        // This node remains connected to its parent (or is a new root).
        return node;
    }
}

struct TreeNode** delNodes(struct TreeNode* root, int* to_delete, int to_deleteSize, int* returnSize) {
    // Initialize the global deletion marker array to false
    for (int i = 0; i <= 1000; ++i) {
        g_is_deleted[i] = false;
    }

    // Mark nodes to be deleted
    for (int i = 0; i < to_deleteSize; ++i) {
        g_is_deleted[to_delete[i]] = true;
    }

    // Allocate memory for the result array of tree roots.
    // Max number of nodes is 1000, so max 1000 roots in the worst case.
    struct TreeNode** forest_roots = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    int forest_count = 0;

    // Start DFS traversal from the root.
    // The initial root has no parent, so parent_was_kept is false.
    dfs(root, false, &forest_roots, &forest_count);

    // Set the actual number of roots found
    *returnSize = forest_count;

    // Reallocate to the exact size needed to save memory
    return (struct TreeNode**)realloc(forest_roots, forest_count * sizeof(struct TreeNode*));
}