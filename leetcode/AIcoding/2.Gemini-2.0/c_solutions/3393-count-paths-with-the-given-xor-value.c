#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countPaths(struct TreeNode* root, int targetSum) {
    int count = 0;
    int pathXor = 0;

    void dfs(struct TreeNode* node, int currentXor) {
        if (node == NULL) {
            return;
        }

        currentXor ^= node->val;

        if (currentXor == targetSum) {
            count++;
        }

        dfs(node->left, currentXor);
        dfs(node->right, currentXor);
    }

    void traverse(struct TreeNode* node) {
        if (node == NULL) {
            return;
        }

        dfs(node, 0);
        traverse(node->left);
        traverse(node->right);
    }

    traverse(root);
    return count;
}