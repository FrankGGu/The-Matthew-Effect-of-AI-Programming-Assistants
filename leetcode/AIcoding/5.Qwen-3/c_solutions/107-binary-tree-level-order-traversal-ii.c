#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int** levelOrderBottom(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int** result = (int**)malloc(sizeof(int*));
    *returnColumnSizes = (int*)malloc(sizeof(int));
    *returnSize = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        int* level = (int*)malloc(levelSize * sizeof(int));
        int* newResult = (int**)realloc(result, (*returnSize + 1) * sizeof(int*));
        int* newReturnColumnSizes = (int*)realloc(*returnColumnSizes, (*returnSize + 1) * sizeof(int));

        result = newResult;
        *returnColumnSizes = newReturnColumnSizes;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            level[i] = node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        result[*returnSize] = level;
        (*returnColumnSizes)[*returnSize] = levelSize;
        (*returnSize)++;
    }

    int** reversedResult = (int**)malloc(*returnSize * sizeof(int*));
    int* reversedReturnColumnSizes = (int*)malloc(*returnSize * sizeof(int));

    for (int i = 0; i < *returnSize; i++) {
        reversedResult[i] = result[*returnSize - 1 - i];
        reversedReturnColumnSizes[i] = (*returnColumnSizes)[*returnSize - 1 - i];
    }

    free(result);
    free(*returnColumnSizes);

    result = reversedResult;
    *returnColumnSizes = reversedReturnColumnSizes;

    return result;
}