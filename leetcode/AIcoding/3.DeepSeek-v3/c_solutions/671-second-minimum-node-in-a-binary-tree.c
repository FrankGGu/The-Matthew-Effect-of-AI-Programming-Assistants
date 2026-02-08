#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void dfs(struct TreeNode* root, int min_val, int* second_min) {
    if (!root) return;

    if (root->val > min_val) {
        if (*second_min == -1 || root->val < *second_min) {
            *second_min = root->val;
        }
    }

    dfs(root->left, min_val, second_min);
    dfs(root->right, min_val, second_min);
}

int findSecondMinimumValue(struct TreeNode* root) {
    if (!root) return -1;

    int min_val = root->val;
    int second_min = -1;

    dfs(root, min_val, &second_min);

    return second_min;
}