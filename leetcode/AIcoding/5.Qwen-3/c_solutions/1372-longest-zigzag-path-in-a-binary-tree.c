#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int longestZigZag(struct TreeNode* root) {
    int maxLen = 0;

    typedef struct {
        int left;
        int right;
    } Result;

    Result dfs(struct TreeNode* node) {
        if (!node) return (Result){0, 0};
        Result left = dfs(node->left);
        Result right = dfs(node->right);
        Result res;
        res.left = left.right + 1;
        res.right = right.left + 1;
        maxLen = (res.left > maxLen) ? res.left : maxLen;
        maxLen = (res.right > maxLen) ? res.right : maxLen;
        return res;
    }

    dfs(root);
    return maxLen;
}