#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int maxLevelSum(struct TreeNode* root) {
    if (!root) return 0;

    int maxSum = root->val;
    int maxLevel = 1;
    int currentLevel = 1;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    int front = 0;
    int rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        int levelSum = 0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            levelSum += node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        if (levelSum > maxSum) {
            maxSum = levelSum;
            maxLevel = currentLevel;
        }

        currentLevel++;
    }

    free(queue);
    return maxLevel;
}