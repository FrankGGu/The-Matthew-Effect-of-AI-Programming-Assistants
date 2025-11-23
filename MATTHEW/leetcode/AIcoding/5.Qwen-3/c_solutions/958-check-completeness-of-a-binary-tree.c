#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int isCompleteTree(struct TreeNode* root) {
    if (!root) return 1;

    int flag = 0;
    TreeNode* queue[1000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        TreeNode* node = queue[front++];
        if (node->left) {
            if (flag) return 0;
            queue[rear++] = node->left;
        } else {
            flag = 1;
        }

        if (node->right) {
            if (flag) return 0;
            queue[rear++] = node->right;
        } else {
            flag = 1;
        }
    }

    return 1;
}