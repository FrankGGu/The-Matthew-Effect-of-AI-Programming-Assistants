#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int** zigzagLevelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
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

    int level = 0;
    while (front < rear) {
        int size = rear - front;
        int* levelData = (int*)malloc(size * sizeof(int));
        int index = 0;

        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front++];
            if (level % 2 == 0) {
                levelData[index++] = node->val;
            } else {
                levelData[size - 1 - i] = node->val;
            }

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        result = (int**)realloc(result, (*returnSize + 1) * sizeof(int*));
        result[*returnSize] = levelData;
        (*returnColumnSizes) = (int*)realloc(*returnColumnSizes, (*returnSize + 1) * sizeof(int));
        (*returnColumnSizes)[*returnSize] = size;
        (*returnSize)++;
        level++;
    }

    free(queue);
    return result;
}