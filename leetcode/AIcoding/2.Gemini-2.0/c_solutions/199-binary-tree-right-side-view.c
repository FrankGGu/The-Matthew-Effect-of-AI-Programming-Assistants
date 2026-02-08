#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* rightSideView(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    int head = 0, tail = 0;

    queue[tail++] = root;

    while (head < tail) {
        int levelSize = tail - head;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[head++];

            if (i == levelSize - 1) {
                result[(*returnSize)++] = node->val;
            }

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