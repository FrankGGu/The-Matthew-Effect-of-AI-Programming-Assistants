#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* recoverFromPreorder(char* traversal) {
    int len = strlen(traversal);
    int pos = 0;

    struct TreeNode* buildTree(int depth) {
        int curDepth = 0;
        int i = pos;
        while (i < len && traversal[i] == '-') {
            curDepth++;
            i++;
        }

        if (curDepth != depth) {
            return NULL;
        }

        pos = i;
        int val = 0;
        while (pos < len && traversal[pos] >= '0' && traversal[pos] <= '9') {
            val = val * 10 + (traversal[pos] - '0');
            pos++;
        }

        struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        node->val = val;
        node->left = NULL;
        node->right = NULL;

        node->left = buildTree(depth + 1);
        node->right = buildTree(depth + 1);

        return node;
    }

    return buildTree(0);
}