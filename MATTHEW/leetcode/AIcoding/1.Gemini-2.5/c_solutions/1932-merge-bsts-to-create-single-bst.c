#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

#define MAX_VAL 100001 // Max node value + 1

struct TreeNode* roots_map[MAX_VAL]; // Maps root_val to TreeNode*
bool all_node_values[MAX_VAL];      // Tracks all unique node values encountered
bool leaf_values[MAX_VAL];          // Tracks values of all initial leaf nodes
bool visited_roots[MAX_VAL];        // Tracks roots that have been attached/visited during DFS

int total_unique_nodes_count; // Count of unique node values across all trees

void dfs_collect_nodes(struct TreeNode* node) {
    if (node == NULL) {
        return;
    }

    if (!all_node_values[node->val]) {
        all_node_values[node->val] = true;
        total_unique_nodes_count++;
    }

    if (node->left == NULL && node->right == NULL) {
        leaf_values[node->val] = true;
    }

    dfs_collect_nodes(node->left);
    dfs_collect_nodes(node->right);
}

bool dfs_validate_and_merge(struct TreeNode* node, long long min_val, long long max_val) {
    if (node == NULL) {
        return true;
    }

    if (node->val <= min_val || node->val >= max_val) {
        return false;
    }

    if (node->left == NULL && node->right == NULL) {
        if (roots_map[node->val] != NULL) {
            if (visited_roots[node->val]) {
                return false;
            }

            visited_roots[node->val] = true;
            struct TreeNode* subtree_root = roots_map[node->val];
            roots_map[node->val] = NULL;

            node->left = subtree_root->left;
            node->right = subtree_root->right;
        }
    }

    bool left_ok = dfs_validate_and_merge(node->left, min_val, node->val);
    if (!left_ok) return false;

    bool right_ok = dfs_validate_and_merge(node->right, node->val, max_val);
    if (!right_ok) return false;

    return true;
}

void dfs_count_nodes(struct TreeNode* node, int* count) {
    if (node == NULL) {
        return;
    }
    (*count)++;
    dfs_count_nodes(node->left, count);
    dfs_count_nodes(node->right, count);
}

struct TreeNode* mergeBSTs(struct TreeNode** trees, int treesSize) {
    for (int i = 0; i < MAX_VAL; ++i) {
        roots_map[i] = NULL;
        all_node_values[i] = false;
        leaf_values[i] = false;
        visited_roots[i] = false;
    }
    total_unique_nodes_count = 0;

    if (treesSize == 0) {
        return NULL;
    }

    for (int i = 0; i < treesSize; ++i) {
        struct TreeNode* current_tree_root = trees[i];
        if (roots_map[current_tree_root->val] != NULL) {
            return NULL;
        }
        roots_map[current_tree_root->val] = current_tree_root;
        dfs_collect_nodes(current_tree_root);
    }

    struct TreeNode* final_root = NULL;
    int root_candidates_count = 0;

    for (int i = 0; i < treesSize; ++i) {
        struct TreeNode* current_tree_root = trees[i];
        if (!leaf_values[current_tree_root->val]) {
            if (final_root != NULL) {
                return NULL;
            }
            final_root = current_tree_root;
            root_candidates_count++;
        }
    }

    if (root_candidates_count != 1 || final_root == NULL) {
        return NULL;
    }

    roots_map[final_root->val] = NULL;
    visited_roots[final_root->val] = true;

    bool success = dfs_validate_and_merge(final_root, LLONG_MIN, LLONG_MAX);
    if (!success) {
        return NULL;
    }

    for (int i = 0; i < MAX_VAL; ++i) {
        if (roots_map[i] != NULL) {
            return NULL;
        }
    }

    int final_node_count = 0;
    dfs_count_nodes(final_root, &final_node_count);

    if (final_node_count != total_unique_nodes_count) {
        return NULL;
    }

    return final_root;
}