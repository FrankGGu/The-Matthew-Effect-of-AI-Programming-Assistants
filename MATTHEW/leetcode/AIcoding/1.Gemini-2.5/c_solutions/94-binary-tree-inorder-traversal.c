#include <stdlib.h>

void inorderHelper(struct TreeNode* node, int** result, int* size, int* capacity) {
    if (node == NULL) {
        return;
    }

    inorderHelper(node->left, result, size, capacity);

    if (*size == *capacity) {
        if (*capacity == 0) {
            *capacity = 1;
        } else {
            *capacity *= 2;
        }
        *result = (int*) realloc(*result, (*capacity) * sizeof(int));
    }
    (*result)[*size] = node->val;
    (*size)++;

    inorderHelper(node->right, result, size, capacity);
}

int* inorderTraversal(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    int capacity = 0;
    int* result = NULL;

    inorderHelper(root, &result, returnSize, &capacity);

    if (*returnSize == 0) {
        return (int*) malloc(0);
    } else {
        result = (int*) realloc(result, (*returnSize) * sizeof(int));
        return result;
    }
}