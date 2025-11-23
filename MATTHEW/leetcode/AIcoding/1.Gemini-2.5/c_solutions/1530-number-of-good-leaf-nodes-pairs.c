#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* dfs(struct TreeNode* node, int distance, int* total_good_pairs) {
    if (node == NULL) {
        return NULL;
    }

    if (node->left == NULL && node->right == NULL) {
        int* leaf_dist_counts = (int*)calloc(distance + 1, sizeof(int));
        leaf_dist_counts[0] = 1;
        return leaf_dist_counts;
    }

    int* left_dist_counts = dfs(node->left, distance, total_good_pairs);
    int* right_dist_counts = dfs(node->right, distance, total_good_pairs);

    if (left_dist_counts != NULL && right_dist_counts != NULL) {
        for (int ld = 0; ld <= distance; ++ld) {
            if (left_dist_counts[ld] == 0) continue;
            for (int rd = 0; rd <= distance; ++rd) {
                if (right_dist_counts[rd] == 0) continue;

                if (ld + rd + 2 <= distance) {
                    *total_good_pairs += left_dist_counts[ld] * right_dist_counts[rd];
                }
            }
        }
    }

    int* current_node_dist_counts = (int*)calloc(distance + 1, sizeof(int));

    if (left_dist_counts != NULL) {
        for (int i = 0; i < distance; ++i) {
            if (left_dist_counts[i] > 0) {
                if (i + 1 <= distance) {
                    current_node_dist_counts[i + 1] += left_dist_counts[i];
                }
            }
        }
        free(left_dist_counts);
    }

    if (right_dist_counts != NULL) {
        for (int i = 0; i < distance; ++i) {
            if (right_dist_counts[i] > 0) {
                if (i + 1 <= distance) {
                    current_node_dist_counts[i + 1] += right_dist_counts[i];
                }
            }
        }
        free(right_dist_counts);
    }

    return current_node_dist_counts;
}

int countPairs(struct TreeNode* root, int distance) {
    int total_good_pairs = 0;
    int* final_dist_counts = dfs(root, distance, &total_good_pairs);
    if (final_dist_counts != NULL) {
        free(final_dist_counts);
    }
    return total_good_pairs;
}