#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfLeftLeaves(struct TreeNode* root) {
    if (!root) return 0;
    int sum = 0;
    if (root->left && !root->left->left && !root->left->right) {
        sum += root->left->val;
    } else {
        sum += sumOfLeftLeaves(root->left);
    }
    sum += sumOfLeftLeaves(root->right);
    return sum;
}