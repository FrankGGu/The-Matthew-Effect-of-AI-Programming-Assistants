#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int** printBinaryTree(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    int height = 0;
    struct TreeNode* node = root;
    int* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        for (int i = 0; i < levelSize; i++) {
            node = queue[front++];
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        height++;
    }

    int** result = (int**)malloc(height * sizeof(int*));
    *returnColumnSizes = (int*)malloc(height * sizeof(int));
    *returnSize = height;

    for (int i = 0; i < height; i++) {
        (*returnColumnSizes)[i] = (1 << i) - 1;
        result[i] = (int*)malloc((*returnColumnSizes)[i] * sizeof(int));
    }

    int index = 0;
    front = 0;
    rear = 0;
    queue[rear++] = root;

    for (int i = 0; i < height; i++) {
        int levelSize = rear - front;
        int pos = 0;
        int space = (1 << (height - i - 1)) - 1;
        for (int j = 0; j < space; j++) {
            result[i][pos++] = 0;
        }
        for (int j = 0; j < levelSize; j++) {
            node = queue[front++];
            result[i][pos++] = node->val;
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
            for (int k = 0; k < space; k++) {
                result[i][pos++] = 0;
            }
        }
    }

    return result;
}