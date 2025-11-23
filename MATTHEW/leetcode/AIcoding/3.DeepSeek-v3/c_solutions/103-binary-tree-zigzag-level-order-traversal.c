#include <stdlib.h>

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

    struct TreeNode** queue = malloc(2000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;

    int** result = malloc(2000 * sizeof(int*));
    *returnColumnSizes = malloc(2000 * sizeof(int));
    *returnSize = 0;

    int leftToRight = 1;

    while (front < rear) {
        int levelSize = rear - front;
        (*returnColumnSizes)[*returnSize] = levelSize;
        result[*returnSize] = malloc(levelSize * sizeof(int));

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            int index = leftToRight ? i : levelSize - 1 - i;
            result[*returnSize][index] = node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        (*returnSize)++;
        leftToRight = !leftToRight;
    }

    free(queue);
    return result;
}