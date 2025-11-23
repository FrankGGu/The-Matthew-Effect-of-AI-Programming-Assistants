#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int findSecondMinimumValue(struct TreeNode* root) {
    if (!root) return -1;

    long min1 = root->val;
    long min2 = -1;

    void dfs(struct TreeNode* node) {
        if (!node) return;

        if (node->val > min1) {
            if (min2 == -1 || node->val < min2) {
                min2 = node->val;
            }
        }

        dfs(node->left);
        dfs(node->right);
    }

    dfs(root);

    return (min2 == -1) ? -1 : (int)min2;
}