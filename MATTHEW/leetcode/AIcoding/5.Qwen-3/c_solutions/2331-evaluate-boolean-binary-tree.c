#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int evaluateTree(struct TreeNode* root) {
    if (root == NULL) return 0;
    if (root->val == 0) return 0;
    if (root->val == 1) return 1;
    int left = evaluateTree(root->left);
    int right = evaluateTree(root->right);
    if (root->val == 2) return left || right;
    if (root->val == 3) return left && right;
    return 0;
}