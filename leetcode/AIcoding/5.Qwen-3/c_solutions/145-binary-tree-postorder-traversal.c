#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* postorderTraversal(struct TreeNode* root, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 100);
    *returnSize = 0;
    struct TreeNode** stack = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 100);
    int top = -1;
    struct TreeNode* prev = NULL;
    struct TreeNode* curr = root;

    while (curr || top >= 0) {
        while (curr) {
            stack[++top] = curr;
            curr = curr->left;
        }
        curr = stack[top];
        if (curr->right == NULL || curr->right == prev) {
            result[*returnSize++] = curr->val;
            prev = curr;
            top--;
            curr = NULL;
        } else {
            curr = curr->right;
        }
    }

    free(stack);
    return result;
}