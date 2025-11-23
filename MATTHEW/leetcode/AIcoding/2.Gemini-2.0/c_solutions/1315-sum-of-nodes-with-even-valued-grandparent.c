#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumEvenGrandparent(struct TreeNode* root) {
    int sum = 0;
    if (root == NULL) return 0;

    if (root->val % 2 == 0) {
        if (root->left != NULL) {
            if (root->left->left != NULL) sum += root->left->left->val;
            if (root->left->right != NULL) sum += root->left->right->val;
        }
        if (root->right != NULL) {
            if (root->right->left != NULL) sum += root->right->left->val;
            if (root->right->right != NULL) sum += root->right->right->val;
        }
    }

    sum += sumEvenGrandparent(root->left);
    sum += sumEvenGrandparent(root->right);

    return sum;
}