#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countGoodNodes(struct TreeNode* root, int maxSoFar) {
    if (!root) return 0;
    int count = 0;
    if (root->val >= maxSoFar) {
        count++;
        maxSoFar = root->val;
    }
    count += countGoodNodes(root->left, maxSoFar);
    count += countGoodNodes(root->right, maxSoFar);
    return count;
}

int goodNodes(struct TreeNode* root) {
    return countGoodNodes(root, INT_MIN);
}