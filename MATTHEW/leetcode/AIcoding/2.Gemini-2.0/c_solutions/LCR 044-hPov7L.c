#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* largestValues(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    int head = 0, tail = 0;
    queue[tail++] = root;

    while (head < tail) {
        int levelSize = tail - head;
        int maxVal = INT_MIN;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[head++];
            if (node->val > maxVal) {
                maxVal = node->val;
            }

            if (node->left) {
                queue[tail++] = node->left;
            }
            if (node->right) {
                queue[tail++] = node->right;
            }
        }
        result[(*returnSize)++] = maxVal;
    }
    free(queue);
    return result;
}