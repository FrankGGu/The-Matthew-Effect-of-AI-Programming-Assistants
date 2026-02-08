#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

double* averageOfLevels(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    double* result = (double*)malloc(sizeof(double) * 1000);
    int index = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 1000);
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        double sum = 0.0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            sum += node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        result[index++] = sum / levelSize;
    }

    *returnSize = index;
    return result;
}