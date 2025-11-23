#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int count[26];
    int odd_count;
} PathInfo;

int dfs(TreeNode* root, PathInfo* path, int* result) {
    if (!root) return 0;

    int idx = root->val;
    path->count[idx]++;
    if (path->count[idx] % 2 == 1) {
        path->odd_count++;
    } else {
        path->odd_count--;
    }

    if (!root->left && !root->right) {
        if (path->odd_count <= 1) {
            (*result)++;
        }
    } else {
        dfs(root->left, path, result);
        dfs(root->right, path, result);
    }

    path->count[idx]--;
    if (path->count[idx] % 2 == 1) {
        path->odd_count++;
    } else {
        path->odd_count--;
    }

    return 0;
}

int countPalindromePaths(TreeNode* root) {
    int result = 0;
    PathInfo path = {0};
    dfs(root, &path, &result);
    return result;
}