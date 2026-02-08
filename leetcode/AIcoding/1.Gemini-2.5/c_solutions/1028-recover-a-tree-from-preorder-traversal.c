#include <stdlib.h>
#include <string.h>
#include <stdio.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* recoverFromPreorder(char* S) {
    if (S == NULL || *S == '\0') {
        return NULL;
    }

    int len = strlen(S);
    struct TreeNode** stack = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * (len / 2 + 1));
    int top = -1;

    int i = 0;
    while (i < len) {
        int depth = 0;
        while (S[i] == '-') {
            depth++;
            i++;
        }

        int val = 0;
        while (i < len && S[i] >= '0' && S[i] <= '9') {
            val = val * 10 + (S[i] - '0');
            i++;
        }

        struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        node->val = val;
        node->left = NULL;
        node->right = NULL;

        while (top >= depth) {
            top--;
        }

        if (top != -1) {
            if (stack[top]->left == NULL) {
                stack[top]->left = node;
            } else {
                stack[top]->right = node;
            }
        }

        top++;
        stack[top] = node;
    }

    struct TreeNode* root = stack[0];
    free(stack);
    return root;
}