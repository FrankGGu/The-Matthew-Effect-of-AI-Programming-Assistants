#include <stdlib.h>

#define MAX_SIZE 10000

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct QueueNode {
    TreeNode *treeNode;
    int level;
} QueueNode;

int* largestValues(struct TreeNode* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    QueueNode queue[MAX_SIZE];
    int front = 0, rear = 0;

    int *result = (int*)malloc(MAX_SIZE * sizeof(int));
    *returnSize = 0;

    queue[rear].treeNode = root;
    queue[rear].level = 0;
    rear++;

    int currentLevel = 0;
    int maxVal = root->val;

    while (front < rear) {
        QueueNode current = queue[front++];
        TreeNode *node = current.treeNode;
        int level = current.level;

        if (level > currentLevel) {
            result[(*returnSize)++] = maxVal;
            currentLevel = level;
            maxVal = node->val;
        } else {
            if (node->val > maxVal) {
                maxVal = node->val;
            }
        }

        if (node->left != NULL) {
            queue[rear].treeNode = node->left;
            queue[rear].level = level + 1;
            rear++;
        }

        if (node->right != NULL) {
            queue[rear].treeNode = node->right;
            queue[rear].level = level + 1;
            rear++;
        }
    }

    result[(*returnSize)++] = maxVal;

    return result;
}