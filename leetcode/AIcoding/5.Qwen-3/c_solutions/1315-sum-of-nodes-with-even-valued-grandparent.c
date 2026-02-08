#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int sumEvenGrandparent(struct TreeNode* root) {
    int sum = 0;
    if (!root) return 0;
    if (root->val % 2 == 0) {
        if (root->left && root->left->left) sum += root->left->left->val;
        if (root->left && root->left->right) sum += root->left->right->val;
        if (root->right && root->right->left) sum += root->right->left->val;
        if (root->right && root->right->right) sum += root->right->right->val;
    }
    sum += sumEvenGrandparent(root->left);
    sum += sumEvenGrandparent(root->right);
    return sum;
}