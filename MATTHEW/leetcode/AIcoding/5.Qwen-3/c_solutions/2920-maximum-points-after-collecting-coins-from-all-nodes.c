#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int maxPoints(TreeNode* root, int depth) {
    if (!root) return 0;
    int left = maxPoints(root->left, depth + 1);
    int right = maxPoints(root->right, depth + 1);
    return (1 << depth) + left + right;
}

int collectTheCoins(struct TreeNode* root) {
    return maxPoints(root, 0);
}