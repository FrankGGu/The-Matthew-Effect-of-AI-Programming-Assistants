#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int deepestLeavesSum(struct TreeNode* root) {
    if (!root) return 0;

    int sum = 0;
    int depth = 0;
    int currentDepth = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    int front = 0;
    int rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        sum = 0;
        currentDepth++;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            sum += node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
    }

    free(queue);
    return sum;
}