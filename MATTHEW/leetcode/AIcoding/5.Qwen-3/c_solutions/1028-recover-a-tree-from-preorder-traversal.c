#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* recoverFromPreorder(char* s) {
    if (!s || s[0] == '\0') return NULL;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    int i = 0, depth = 0;
    char* num = (char*)malloc(10 * sizeof(char));
    int numIndex = 0;

    while (s[i] && s[i] != '-') {
        num[numIndex++] = s[i++];
    }
    num[numIndex] = '\0';
    root->val = atoi(num);
    free(num);

    struct TreeNode** stack = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    int stackSize = 1;
    stack[0] = root;

    while (s[i]) {
        depth = 0;
        while (s[i] == '-') {
            i++;
            depth++;
        }

        numIndex = 0;
        num = (char*)malloc(10 * sizeof(char));
        while (s[i] && s[i] != '-') {
            num[numIndex++] = s[i++];
        }
        num[numIndex] = '\0';
        struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        node->val = atoi(num);
        free(num);

        while (stackSize > depth) {
            stackSize--;
        }

        if (stack[stackSize - 1]->left) {
            stack[stackSize - 1]->right = node;
        } else {
            stack[stackSize - 1]->left = node;
        }

        stack = (struct TreeNode**)realloc(stack, (stackSize + 1) * sizeof(struct TreeNode*));
        stack[stackSize++] = node;
    }

    free(stack);
    return root;
}