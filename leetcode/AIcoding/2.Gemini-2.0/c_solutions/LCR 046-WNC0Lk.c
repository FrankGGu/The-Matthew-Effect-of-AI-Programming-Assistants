#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* rightSideView(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    int head = 0;
    int tail = 0;
    queue[tail++] = root;

    while (head < tail) {
        int levelSize = tail - head;
        result[(*returnSize)++] = queue[tail - 1]->val;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[head++];
            if (node->left) {
                queue[tail++] = node->left;
            }
            if (node->right) {
                queue[tail++] = node->right;
            }
        }
    }

    free(queue);
    return result;
}