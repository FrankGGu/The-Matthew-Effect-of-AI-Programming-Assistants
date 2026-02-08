#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void dfs(struct TreeNode* node, int* count, int* result) {
    if (!node) return;

    count[node->val]++;

    if (!node->left && !node->right) {
        int odd = 0;
        for (int i = 1; i <= 9; i++) {
            if (count[i] % 2 == 1) {
                odd++;
            }
        }
        if (odd <= 1) {
            (*result)++;
        }
    } else {
        dfs(node->left, count, result);
        dfs(node->right, count, result);
    }

    count[node->val]--;
}

int pseudoPalindromicPaths(struct TreeNode* root) {
    int* count = (int*)calloc(10, sizeof(int));
    int result = 0;
    dfs(root, count, &result);
    free(count);
    return result;
}