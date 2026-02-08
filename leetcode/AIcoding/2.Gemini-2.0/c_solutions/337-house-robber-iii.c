#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* robHelper(struct TreeNode* root) {
    if (!root) {
        int* res = (int*)malloc(2 * sizeof(int));
        res[0] = 0;
        res[1] = 0;
        return res;
    }

    int* left = robHelper(root->left);
    int* right = robHelper(root->right);

    int* res = (int*)malloc(2 * sizeof(int));
    res[0] = root->val + left[1] + right[1];
    res[1] = (left[0] > left[1] ? left[0] : left[1]) + (right[0] > right[1] ? right[0] : right[1]);

    free(left);
    free(right);
    return res;
}

int rob(struct TreeNode* root) {
    int* res = robHelper(root);
    int result = (res[0] > res[1] ? res[0] : res[1]);
    free(res);
    return result;
}