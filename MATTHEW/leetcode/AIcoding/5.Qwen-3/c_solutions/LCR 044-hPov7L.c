#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int* largestValues(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int** result = (int**)malloc(sizeof(int*));
    int resultSize = 0;
    int* currentLevel = (int*)malloc(sizeof(int));
    int currentSize = 0;
    int* nextLevel = (int*)malloc(sizeof(int));
    int nextSize = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    int front = 0;
    int rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        int maxVal = INT_MIN;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            maxVal = (node->val > maxVal) ? node->val : maxVal;

            if (node->left) {
                if (nextSize == 0) {
                    nextLevel = (int*)malloc(sizeof(int));
                } else {
                    nextLevel = (int*)realloc(nextLevel, (nextSize + 1) * sizeof(int));
                }
                nextLevel[nextSize++] = node->left->val;
            }

            if (node->right) {
                if (nextSize == 0) {
                    nextLevel = (int*)malloc(sizeof(int));
                } else {
                    nextLevel = (int*)realloc(nextLevel, (nextSize + 1) * sizeof(int));
                }
                nextLevel[nextSize++] = node->right->val;
            }
        }

        result[resultSize++] = (int*)malloc(sizeof(int));
        result[resultSize - 1][0] = maxVal;

        if (nextSize > 0) {
            queue = (struct TreeNode**)malloc(nextSize * sizeof(struct TreeNode*));
            for (int i = 0; i < nextSize; i++) {
                queue[i] = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                queue[i]->val = nextLevel[i];
                queue[i]->left = NULL;
                queue[i]->right = NULL;
            }
            front = 0;
            rear = nextSize;
            free(nextLevel);
            nextSize = 0;
        }
    }

    *returnSize = resultSize;
    int* output = (int*)malloc(resultSize * sizeof(int));
    for (int i = 0; i < resultSize; i++) {
        output[i] = result[i][0];
        free(result[i]);
    }
    free(result);
    free(queue);

    return output;
}