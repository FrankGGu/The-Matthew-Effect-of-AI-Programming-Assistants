#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* postorderTraversal(struct TreeNode* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(100 * sizeof(int)); 
    int index = 0;

    struct TreeNode* stack[100];
    int top = -1;
    struct TreeNode* lastVisited = NULL;
    struct TreeNode* curr = root;

    while (curr != NULL || top != -1) {
        while (curr != NULL) {
            stack[++top] = curr;
            curr = curr->left;
        }

        curr = stack[top];

        if (curr->right == NULL || curr->right == lastVisited) {
            result[index++] = curr->val;
            lastVisited = curr;
            top--;
            curr = NULL; 
        } else {
            curr = curr->right;
        }
    }

    *returnSize = index;
    return result;
}