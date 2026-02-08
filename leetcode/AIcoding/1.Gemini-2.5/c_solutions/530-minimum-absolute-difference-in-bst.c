#include <stdlib.h> // For abs
#include <limits.h> // For INT_MAX

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void inorder_helper(struct TreeNode* node, int* min_diff_ptr, int* prev_val_ptr) {
    if (node == NULL) {
        return;
    }

    inorder_helper(node->left, min_diff_ptr, prev_val_ptr);

    if (*prev_val_ptr != -1) {
        int current_diff = abs(node->val - *prev_val_ptr);
        if (current_diff < *min_diff_ptr) {
            *min_diff_ptr = current_diff;
        }
    }
    *prev_val_ptr = node->val;

    inorder_helper(node->right, min_diff_ptr, prev_val_ptr);
}

int getMinimumDifference(struct TreeNode* root) {
    int min_diff = INT_MAX;
    int prev_val = -1; 

    inorder_helper(root, &min_diff, &prev_val);

    return min_diff;
}