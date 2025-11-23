#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countNodes(struct TreeNode* root){
    if (root == NULL) {
        return 0;
    }

    int leftHeight = 0;
    struct TreeNode* leftNode = root;
    while (leftNode != NULL) {
        leftHeight++;
        leftNode = leftNode->left;
    }

    int rightHeight = 0;
    struct TreeNode* rightNode = root;
    while (rightNode != NULL) {
        rightHeight++;
        rightNode = rightNode->right;
    }

    if (leftHeight == rightHeight) {
        return (1 << leftHeight) - 1;
    }

    return 1 + countNodes(root->left) + countNodes(root->right);
}