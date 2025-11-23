#include <stdlib.h>

void dfs(struct TreeNode* node, int depth, int** result, int* returnSize, int* capacity) {
    if (node == NULL) {
        return;
    }

    if (depth == *returnSize) {
        if (*returnSize == *capacity) {
            *capacity *= 2;
            *result = (int*)realloc(*result, sizeof(int) * (*capacity));
        }
        (*result)[(*returnSize)++] = node->val;
    }

    dfs(node->right, depth + 1, result, returnSize, capacity);
    dfs(node->left, depth + 1, result, returnSize, capacity);
}

int* rightSideView(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    if (root == NULL) {
        return (int*)malloc(0);
    }

    int initialCapacity = 10;
    int* result = (int*)malloc(sizeof(int) * initialCapacity);
    int capacity = initialCapacity;

    dfs(root, 0, &result, returnSize, &capacity);

    int* finalResult = (int*)realloc(result, sizeof(int) * (*returnSize));
    if (finalResult == NULL) {
        return result;
    }
    return finalResult;
}