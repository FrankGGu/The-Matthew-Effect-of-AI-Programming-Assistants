#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int findBottomLeftValue(struct TreeNode* root) {
    struct TreeNode** queue = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;
    struct TreeNode* leftmost = root;

    while (front < rear) {
        int levelSize = rear - front;
        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            if (i == 0) {
                leftmost = node;
            }
            if (node->left) {
                queue[rear++] = node->left;
            }
            if (node->right) {
                queue[rear++] = node->right;
            }
        }
    }

    free(queue);
    return leftmost->val;
}