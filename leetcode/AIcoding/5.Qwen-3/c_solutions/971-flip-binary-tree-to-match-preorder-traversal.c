#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* flipMatchVoyage(struct TreeNode* root, int* voyage, int voyageSize, int* returnSize) {
    int* result = (int*)malloc(voyageSize * sizeof(int));
    *returnSize = 0;
    int index = 0;

    int* stack = (int*)malloc(voyageSize * sizeof(int));
    int top = -1;

    struct TreeNode* current = root;

    while (current != NULL || top >= 0) {
        while (current != NULL) {
            if (current->val != voyage[index]) {
                *returnSize = -1;
                free(result);
                free(stack);
                return NULL;
            }
            index++;
            stack[++top] = current->val;
            current = current->left;
        }

        current = NULL;
        while (top >= 0 && current == NULL) {
            current = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            current->val = stack[top];
            current->left = NULL;
            current->right = NULL;
            top--;
            if (current->val != voyage[index]) {
                *returnSize = -1;
                free(result);
                free(stack);
                return NULL;
            }
            index++;
            if (current->left != NULL && current->left->val != voyage[index]) {
                struct TreeNode* temp = current->left;
                current->left = current->right;
                current->right = temp;
                result[*returnSize] = current->val;
                (*returnSize)++;
            }
            current = current->right;
        }
    }

    free(stack);
    return result;
}