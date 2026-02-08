#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void postorderHelper(struct TreeNode* root, int** result, int* returnSize, int* capacity) {
    if (root == NULL) {
        return;
    }

    postorderHelper(root->left, result, returnSize, capacity);
    postorderHelper(root->right, result, returnSize, capacity);

    if (*returnSize == *capacity) {
        *capacity *= 2;
        *result = (int*)realloc(*result, (*capacity) * sizeof(int));
    }
    (*result)[(*returnSize)++] = root->val;
}

int* postorderTraversal(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    int capacity = 10;
    int* result = (int*)malloc(capacity * sizeof(int));

    postorderHelper(root, &result, returnSize, &capacity);

    if (*returnSize == 0) {
        free(result);
        return NULL;
    }

    result = (int*)realloc(result, (*returnSize) * sizeof(int));
    return result;
}