#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* reverseOddLevels(struct TreeNode* root) {
    if (!root) return NULL;

    struct TreeNode** queue = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;

    int level = 0;

    while (front < rear) {
        int size = rear - front;
        struct TreeNode** level_nodes = (struct TreeNode**)malloc(size * sizeof(struct TreeNode*));
        for (int i = 0; i < size; i++) {
            level_nodes[i] = queue[front + i];
        }

        if (level % 2 == 1) {
            for (int i = 0; i < size / 2; i++) {
                int temp = level_nodes[i]->val;
                level_nodes[i]->val = level_nodes[size - 1 - i]->val;
                level_nodes[size - 1 - i]->val = temp;
            }
        }

        for (int i = 0; i < size; i++) {
            struct TreeNode* node = level_nodes[i];
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        free(level_nodes);
        front = rear;
        level++;
    }

    free(queue);
    return root;
}