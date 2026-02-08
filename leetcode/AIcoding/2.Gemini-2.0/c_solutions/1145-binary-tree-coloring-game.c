#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int count(struct TreeNode* root, int x, int* left, int* right) {
    if (!root) return 0;
    int l = count(root->left, x, left, right);
    int r = count(root->right, x, left, right);
    if (root->val == x) {
        *left = l;
        *right = r;
        return 0;
    }
    return l + r + 1;
}

bool btreeGameWinningMove(struct TreeNode* root, int n, int x) {
    int left, right;
    count(root, x, &left, &right);
    if (left > n / 2 || right > n / 2 || (n - left - right - 1) > n / 2) return true;
    return false;
}