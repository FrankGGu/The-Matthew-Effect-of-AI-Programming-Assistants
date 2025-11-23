#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* addOneRow(struct TreeNode* root, int val, int depth) {
    if (depth == 1) {
        struct TreeNode* newRoot = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newRoot->val = val;
        newRoot->left = root;
        newRoot->right = NULL;
        return newRoot;
    }

    void dfs(struct TreeNode* node, int currentDepth) {
        if (!node) {
            return;
        }

        if (currentDepth == depth - 1) {
            struct TreeNode* leftNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            leftNode->val = val;
            leftNode->left = node->left;
            leftNode->right = NULL;
            node->left = leftNode;

            struct TreeNode* rightNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            rightNode->val = val;
            rightNode->right = node->right;
            rightNode->left = NULL;
            node->right = rightNode;

            return;
        }

        dfs(node->left, currentDepth + 1);
        dfs(node->right, currentDepth + 1);
    }

    dfs(root, 1);
    return root;
}