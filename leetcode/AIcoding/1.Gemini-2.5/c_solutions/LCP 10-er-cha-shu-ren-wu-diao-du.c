#include <stdlib.h>
#include <math.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* dfs(struct TreeNode* node) {
    int* res = (int*)malloc(sizeof(int) * 2);
    res[0] = 0;
    res[1] = 0;

    if (!node) {
        return res;
    }

    int* left_res = dfs(node->left);
    int* right_res = dfs(node->right);

    res[0] = fmax(left_res[0], left_res[1]) + fmax(right_res[0], right_res[1]);

    res[1] = node->val + left_res[0] + right_res[0];

    free(left_res);
    free(right_res);

    return res;
}

int rob(struct TreeNode* root) {
    int* final_res = dfs(root);
    int result = fmax(final_res[0], final_res[1]);
    free(final_res);
    return result;
}