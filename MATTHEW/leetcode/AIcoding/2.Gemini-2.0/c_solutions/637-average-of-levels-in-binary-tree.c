#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

    double* result = (double*)malloc(10000 * sizeof(double));
    *returnSize = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    int head = 0;
    int tail = 0;

    queue[tail++] = root;

    while (head < tail) {
        int levelSize = tail - head;
        double sum = 0.0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[head++];
            sum += node->val;

            if (node->left) {
                queue[tail++] = node->left;
            }
            if (node->right) {
                queue[tail++] = node->right;
            }
        }

        result[(*returnSize)++] = sum / levelSize;
    }

    free(queue);
    return result;
}