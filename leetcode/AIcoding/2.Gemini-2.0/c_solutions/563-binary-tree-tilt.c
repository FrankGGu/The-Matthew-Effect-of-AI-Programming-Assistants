#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int abs(int x) {
    return (x < 0) ? -x : x;
}

int findTiltHelper(struct TreeNode* root, int* tilt) {
    if (root == NULL) return 0;

    int leftSum = findTiltHelper(root->left, tilt);
    int rightSum = findTiltHelper(root->right, tilt);

    *tilt += abs(leftSum - rightSum);

    return root->val + leftSum + rightSum;
}

int findTilt(struct TreeNode* root) {
    int tilt = 0;
    findTiltHelper(root, &tilt);
    return tilt;
}