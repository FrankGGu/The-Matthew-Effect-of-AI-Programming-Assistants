#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int** zigzagLevelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int** result = (int**)malloc(sizeof(int*) * 2000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 2000);
    *returnSize = 0;

    struct TreeNode* queue[2000];
    int head = 0, tail = 0;
    queue[tail++] = root;

    int level = 0;
    while (head < tail) {
        int levelSize = tail - head;
        result[*returnSize] = (int*)malloc(sizeof(int) * levelSize);
        (*returnColumnSizes)[*returnSize] = levelSize;

        if (level % 2 == 0) {
            for (int i = 0; i < levelSize; i++) {
                struct TreeNode* node = queue[head++];
                result[*returnSize][i] = node->val;
                if (node->left) queue[tail++] = node->left;
                if (node->right) queue[tail++] = node->right;
            }
        } else {
            for (int i = 0; i < levelSize; i++) {
                struct TreeNode* node = queue[head++];
                result[*returnSize][levelSize - 1 - i] = node->val;
                if (node->left) queue[tail++] = node->left;
                if (node->right) queue[tail++] = node->right;
            }
        }

        (*returnSize)++;
        level++;
    }

    return result;
}