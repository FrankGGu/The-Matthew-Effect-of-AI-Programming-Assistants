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

    int** queue = (int**)malloc(sizeof(int*) * 1000);
    int front = 0, rear = 0;
    int* result = (int*)malloc(sizeof(int) * 1000);
    int resultIndex = 0;

    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        int maxVal = INT_MIN;

        for (int i = 0; i < levelSize; i++) {
            TreeNode* node = queue[front + i];
            if (node->val > maxVal) {
                maxVal = node->val;
            }
            if (node->left) {
                queue[rear++] = node->left;
            }
            if (node->right) {
                queue[rear++] = node->right;
            }
        }

        result[resultIndex++] = maxVal;
        front += levelSize;
    }

    *returnSize = resultIndex;
    return result;
}