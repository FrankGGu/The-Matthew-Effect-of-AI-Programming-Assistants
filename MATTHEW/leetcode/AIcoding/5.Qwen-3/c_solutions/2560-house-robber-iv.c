#include <stdio.h>
#include <stdlib.h>

int rob(struct TreeNode* root) {
    if (!root) return 0;

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0; // not robbed
    result[1] = 0; // robbed

    int left_not_robbed = 0;
    int left_robbed = 0;
    int right_not_robbed = 0;
    int right_robbed = 0;

    if (root->left) {
        int* left = rob(root->left);
        left_not_robbed = left[0];
        left_robbed = left[1];
        free(left);
    }

    if (root->right) {
        int* right = rob(root->right);
        right_not_robbed = right[0];
        right_robbed = right[1];
        free(right);
    }

    result[0] = fmax(left_not_robbed + right_not_robbed, fmax(left_not_robbed + right_robbed, left_robbed + right_not_robbed));
    result[1] = root->val + left_not_robbed + right_not_robbed;

    return result;
}