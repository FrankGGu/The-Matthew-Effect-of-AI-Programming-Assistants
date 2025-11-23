#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int findBottomLeftValue(struct TreeNode* root) {
    int bottomLeft = 0;
    int maxDepth = -1;

    void traverse(struct TreeNode* node, int depth) {
        if (node == NULL) {
            return;
        }

        if (depth > maxDepth) {
            maxDepth = depth;
            bottomLeft = node->val;
        }

        traverse(node->left, depth + 1);
        traverse(node->right, depth + 1);
    }

    traverse(root, 0);
    return bottomLeft;
}