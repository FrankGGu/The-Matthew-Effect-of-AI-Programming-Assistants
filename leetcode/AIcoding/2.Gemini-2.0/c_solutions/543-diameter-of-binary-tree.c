#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDepth(struct TreeNode* root, int* diameter) {
    if (root == NULL) {
        return 0;
    }

    int leftDepth = maxDepth(root->left, diameter);
    int rightDepth = maxDepth(root->right, diameter);

    int currentDiameter = leftDepth + rightDepth;
    if (currentDiameter > *diameter) {
        *diameter = currentDiameter;
    }

    return 1 + (leftDepth > rightDepth ? leftDepth : rightDepth);
}

int diameterOfBinaryTree(struct TreeNode* root) {
    int diameter = 0;
    maxDepth(root, &diameter);
    return diameter;
}