#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int treeDiameter(struct TreeNode* root) {
    int diameter = 0;

    int depth(struct TreeNode* node) {
        if (!node) {
            return 0;
        }

        int leftDepth = depth(node->left);
        int rightDepth = depth(node->right);

        diameter = (diameter > (leftDepth + rightDepth)) ? diameter : (leftDepth + rightDepth);

        return (leftDepth > rightDepth ? leftDepth : rightDepth) + 1;
    }

    depth(root);
    return diameter;
}