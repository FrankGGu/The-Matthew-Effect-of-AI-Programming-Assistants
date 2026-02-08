#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int diameterOfBinaryTree(struct TreeNode* root) {
    int diameter = 0;

    int height(struct TreeNode* node) {
        if (!node) return 0;
        int leftHeight = height(node->left);
        int rightHeight = height(node->right);
        diameter = (leftHeight + rightHeight) > diameter ? (leftHeight + rightHeight) : diameter;
        return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
    }

    height(root);
    return diameter;
}