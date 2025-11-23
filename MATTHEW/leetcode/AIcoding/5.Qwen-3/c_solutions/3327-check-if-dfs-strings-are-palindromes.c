#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    char val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

bool isPalindrome(char *s, int left, int right) {
    while (left < right) {
        if (s[left] != s[right]) return false;
        left++;
        right--;
    }
    return true;
}

void dfs(TreeNode* root, char* path, int* index, bool* result) {
    if (!root || *result) return;
    path[*index] = root->val;
    (*index)++;
    if (!root->left && !root->right) {
        *result = isPalindrome(path, 0, *index - 1);
    } else {
        dfs(root->left, path, index, result);
        dfs(root->right, path, index, result);
    }
    (*index)--;
}

bool isPalindromePossible(TreeNode* root) {
    char path[1000];
    int index = 0;
    bool result = false;
    dfs(root, path, &index, &result);
    return result;
}