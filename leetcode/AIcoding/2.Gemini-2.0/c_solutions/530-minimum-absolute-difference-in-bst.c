#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDiff = INT_MAX;
int prev = -1;

void inorder(struct TreeNode* root) {
    if (root == NULL) return;

    inorder(root->left);

    if (prev != -1) {
        int diff = abs(root->val - prev);
        if (diff < minDiff) {
            minDiff = diff;
        }
    }
    prev = root->val;

    inorder(root->right);
}

int getMinimumDifference(struct TreeNode* root){
    minDiff = INT_MAX;
    prev = -1;
    inorder(root);
    return minDiff;
}