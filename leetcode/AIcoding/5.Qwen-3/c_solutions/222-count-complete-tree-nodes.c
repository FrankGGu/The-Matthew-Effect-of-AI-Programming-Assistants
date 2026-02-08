#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int countNodes(struct TreeNode* root) {
    if (root == NULL) return 0;

    int leftHeight = 0, rightHeight = 0;
    struct TreeNode* leftNode = root->left;
    struct TreeNode* rightNode = root->right;

    while (leftNode) {
        leftHeight++;
        leftNode = leftNode->left;
    }

    while (rightNode) {
        rightHeight++;
        rightNode = rightNode->right;
    }

    if (leftHeight == rightHeight) {
        return (1 << leftHeight) - 1;
    } else {
        return 1 + countNodes(root->left) + countNodes(root->right);
    }
}