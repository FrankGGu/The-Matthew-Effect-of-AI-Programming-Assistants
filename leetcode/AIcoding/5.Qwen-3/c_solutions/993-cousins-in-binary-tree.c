#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int isSameLevel(TreeNode* root, int x, int y, int level) {
    if (root == NULL) return -1;
    if (root->val == x || root->val == y) return level;
    int left = isSameLevel(root->left, x, y, level + 1);
    int right = isSameLevel(root->right, x, y, level + 1);
    return (left != -1) ? left : right;
}

int isSibling(TreeNode* root, int x, int y) {
    if (root == NULL) return 0;
    return ((root->left && root->right && 
             ((root->left->val == x && root->right->val == y) || 
              (root->left->val == y && root->right->val == x)))) ||
           isSibling(root->left, x, y) || isSibling(root->right, x, y);
}

int isCousin(TreeNode* root, int x, int y) {
    int levelX = isSameLevel(root, x, y, 0);
    int levelY = isSameLevel(root, y, x, 0);
    return (levelX == levelY) && !isSibling(root, x, y);
}

bool isCousins(struct TreeNode* root, int x, int y) {
    return isCousins(root, x, y);
}