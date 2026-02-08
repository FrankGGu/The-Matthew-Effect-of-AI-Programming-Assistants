#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int findSecondMinimumValue(struct TreeNode* root) {
    int min1 = root->val;
    int min2 = -1;
    struct TreeNode* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    while (front < rear) {
        struct TreeNode* node = queue[front++];
        if (node->val != min1) {
            if (min2 == -1 || node->val < min2) {
                min2 = node->val;
            }
        }
        if (node->left) {
            queue[rear++] = node->left;
        }
        if (node->right) {
            queue[rear++] = node->right;
        }
    }
    return min2;
}