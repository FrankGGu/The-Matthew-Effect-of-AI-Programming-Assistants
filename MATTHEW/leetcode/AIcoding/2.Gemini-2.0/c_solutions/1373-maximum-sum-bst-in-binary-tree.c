#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct Info {
    int isBST;
    int min;
    int max;
    int sum;
};

int maxSum = 0;

struct Info helper(struct TreeNode* root) {
    if (!root) {
        struct Info info = {1, INT_MAX, INT_MIN, 0};
        return info;
    }

    struct Info left = helper(root->left);
    struct Info right = helper(root->right);

    struct Info current;
    current.sum = root->val + left.sum + right.sum;

    if (left.isBST && right.isBST && root->val > left.max && root->val < right.min) {
        current.isBST = 1;
        current.min = (root->left) ? left.min : root->val;
        current.max = (root->right) ? right.max : root->val;
        maxSum = (current.sum > maxSum) ? current.sum : maxSum;
    } else {
        current.isBST = 0;
    }

    return current;
}

int maxSumBST(struct TreeNode* root){
    maxSum = 0;
    helper(root);
    return maxSum;
}