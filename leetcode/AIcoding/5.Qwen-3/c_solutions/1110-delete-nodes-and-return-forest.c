#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode** delNodes(struct TreeNode* root, int* to_delete, int to_deleteSize, int* returnSize) {
    int* hash = (int*)calloc(1001, sizeof(int));
    for (int i = 0; i < to_deleteSize; i++) {
        hash[to_delete[i]] = 1;
    }

    struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    *returnSize = 0;

    struct TreeNode* dfs(struct TreeNode* node) {
        if (!node) return NULL;
        node->left = dfs(node->left);
        node->right = dfs(node->right);
        if (hash[node->val]) {
            if (node->left) result[*returnSize++] = node->left;
            if (node->right) result[*returnSize++] = node->right;
            free(node);
            return NULL;
        }
        return node;
    }

    dfs(root);
    return result;
}