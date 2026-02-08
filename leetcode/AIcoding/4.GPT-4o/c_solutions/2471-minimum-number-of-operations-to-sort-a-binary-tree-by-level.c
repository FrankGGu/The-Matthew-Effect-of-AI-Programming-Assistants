#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minimumOperations(struct TreeNode* root) {
    if (!root) return 0;

    int operations = 0;
    int level = 0;
    struct TreeNode** queue = malloc(1000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;

    queue[rear++] = root;

    while (front < rear) {
        int size = rear - front;
        int* values = malloc(size * sizeof(int));
        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front++];
            values[i] = node->val;
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        int* sortedValues = malloc(size * sizeof(int));
        memcpy(sortedValues, values, size * sizeof(int));
        qsort(sortedValues, size, sizeof(int), cmp);

        for (int i = 0; i < size; i++) {
            if (values[i] != sortedValues[i]) {
                operations++;
            }
        }

        free(values);
        free(sortedValues);
        level++;
    }

    free(queue);
    return operations;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}