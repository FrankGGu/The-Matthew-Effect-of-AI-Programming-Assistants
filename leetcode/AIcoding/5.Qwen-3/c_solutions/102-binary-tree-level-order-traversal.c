#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int** levelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
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
        int* levelValues = (int*)malloc(levelSize * sizeof(int));
        int* temp = (int*)realloc(*returnColumnSizes, (*returnSize + 1) * sizeof(int));
        *returnColumnSizes = temp;
        (*returnColumnSizes)[*returnSize] = levelSize;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            levelValues[i] = node->val;

            if (node->left) {
                queue = (struct TreeNode**)realloc(queue, (rear + 1) * sizeof(struct TreeNode*));
                queue[rear++] = node->left;
            }
            if (node->right) {
                queue = (struct TreeNode**)realloc(queue, (rear + 1) * sizeof(struct TreeNode*));
                queue[rear++] = node->right;
            }
        }

        result = (int**)realloc(result, (*returnSize + 1) * sizeof(int*));
        result[*returnSize] = levelValues;
        (*returnSize)++;
    }

    free(queue);
    return result;
}