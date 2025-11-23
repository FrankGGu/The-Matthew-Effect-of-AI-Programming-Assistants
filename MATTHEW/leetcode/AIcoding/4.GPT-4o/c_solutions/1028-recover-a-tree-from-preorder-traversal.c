#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* recoverFromPreorder(char *S) {
    int n = strlen(S);
    int index = 0;

    struct TreeNode* buildTree(int depth) {
        if (index == n) return NULL;
        int currentDepth = 0;
        while (index < n && S[index] == '-') {
            currentDepth++;
            index++;
        }
        if (currentDepth != depth) {
            index -= currentDepth;
            return NULL;
        }

        int value = 0;
        while (index < n && S[index] >= '0' && S[index] <= '9') {
            value = value * 10 + (S[index] - '0');
            index++;
        }

        struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        node->val = value;
        node->left = buildTree(depth + 1);
        node->right = buildTree(depth + 1);
        return node;
    }

    return buildTree(0);
}