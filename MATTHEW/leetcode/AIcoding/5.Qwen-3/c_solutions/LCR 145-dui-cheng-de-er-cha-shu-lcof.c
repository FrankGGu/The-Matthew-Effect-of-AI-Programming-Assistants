#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int isSameTree(struct TreeNode* p, struct TreeNode* q) {
    if (p == NULL && q == NULL) return 1;
    if (p == NULL || q == NULL) return 0;
    return (p->val == q->val) && isSameTree(p->left, q->right) && isSameTree(p->right, q->left);
}

int isSymmetric(struct TreeNode* root) {
    if (root == NULL) return 1;
    return isSameTree(root->left, root->right);
}