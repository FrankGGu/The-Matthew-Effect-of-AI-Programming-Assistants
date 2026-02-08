#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* recoverFromPreorder(char* S) {
    int len = strlen(S);
    if (len == 0) return NULL;

    struct TreeNode** stack = (struct TreeNode**)malloc(len * sizeof(struct TreeNode*));
    int* depthStack = (int*)malloc(len * sizeof(int));
    int top = -1;

    int i = 0;
    while (i < len) {
        int depth = 0;
        while (i < len && S[i] == '-') {
            depth++;
            i++;
        }

        int num = 0;
        while (i < len && S[i] != '-') {
            num = num * 10 + (S[i] - '0');
            i++;
        }

        struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        node->val = num;
        node->left = node->right = NULL;

        while (top >= 0 && depth <= depthStack[top]) {
            top--;
        }

        if (top >= 0) {
            if (stack[top]->left == NULL) {
                stack[top]->left = node;
            } else {
                stack[top]->right = node;
            }
        }

        top++;
        stack[top] = node;
        depthStack[top] = depth;
    }

    struct TreeNode* root = stack[0];
    free(stack);
    free(depthStack);
    return root;
}