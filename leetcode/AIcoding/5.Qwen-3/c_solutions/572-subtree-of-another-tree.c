#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int isSameTree(struct TreeNode* s, struct TreeNode* t) {
    if (s == NULL && t == NULL) return 1;
    if (s == NULL || t == NULL) return 0;
    return (s->val == t->val && isSameTree(s->left, t->left) && isSameTree(s->right, t->right));
}

int isSubtree(struct TreeNode* root, struct TreeNode* subRoot) {
    if (subRoot == NULL) return 1;
    if (root == NULL) return 0;
    if (isSameTree(root, subRoot)) return 1;
    return isSubtree(root->left, subRoot) || isSubtree(root->right, subRoot);
}