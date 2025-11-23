#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int goodNodesHelper(struct TreeNode* root, int maxVal) {
    if (root == NULL) {
        return 0;
    }

    int count = 0;
    if (root->val >= maxVal) {
        count = 1;
        maxVal = root->val;
    }

    count += goodNodesHelper(root->left, maxVal);
    count += goodNodesHelper(root->right, maxVal);

    return count;
}

int goodNodes(struct TreeNode* root) {
    return goodNodesHelper(root, -2147483648);
}