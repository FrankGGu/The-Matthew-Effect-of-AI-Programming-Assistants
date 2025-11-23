#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* replaceValueInTree(struct TreeNode* root) {
    if (!root) return NULL;

    root->val = 0;

    struct TreeNode* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int size = rear - front;
        int sum = 0;
        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front++];
            if (node->left) {
                sum += node->left->val;
            }
            if (node->right) {
                sum += node->right->val;
            }
        }

        front -= size;
        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front++];
            int siblingSum = 0;
            if (node->left) {
                if (node->right) {
                    siblingSum = node->right->val;
                }
                node->left->val = sum - node->left->val - siblingSum;
                queue[rear++] = node->left;
            }
            if (node->right) {
                if (node->left) {
                    siblingSum = node->left->val;
                } else {
                    siblingSum = 0;
                }
                node->right->val = sum - node->right->val - siblingSum;
                queue[rear++] = node->right;
            }
        }
    }

    return root;
}