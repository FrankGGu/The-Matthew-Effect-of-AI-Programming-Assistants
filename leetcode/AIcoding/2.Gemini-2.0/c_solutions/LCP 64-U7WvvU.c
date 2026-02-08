#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int dfs(struct TreeNode* root, int* ans) {
    if (!root) {
        return 0;
    }

    int left = dfs(root->left, ans);
    int right = dfs(root->right, ans);

    if (left == 0 && right == 0) {
        return 1;
    } else if (left == 1 || right == 1) {
        (*ans)++;
        return -1;
    } else {
        return 0;
    }
}

int light(struct TreeNode* root) {
    int ans = 0;
    if (dfs(root, &ans) == 1) {
        ans++;
    }
    return ans;
}