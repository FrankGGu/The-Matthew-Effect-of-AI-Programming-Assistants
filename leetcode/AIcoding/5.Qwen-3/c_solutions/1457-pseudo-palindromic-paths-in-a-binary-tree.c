#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int isPseudoPalindrome(int *path, int pathLength) {
    int oddCount = 0;
    for (int i = 0; i < 10; i++) {
        if (path[i] % 2 != 0) {
            oddCount++;
        }
    }
    return oddCount <= 1;
}

void dfs(struct TreeNode *root, int *path, int *count) {
    if (!root) return;
    path[root->val]++;
    if (!root->left && !root->right) {
        if (isPseudoPalindrome(path, 10)) {
            (*count)++;
        }
    } else {
        dfs(root->left, path, count);
        dfs(root->right, path, count);
    }
    path[root->val]--;
}

int pseudoPalindromicPaths (struct TreeNode* root) {
    int path[10] = {0};
    int count = 0;
    dfs(root, path, &count);
    return count;
}