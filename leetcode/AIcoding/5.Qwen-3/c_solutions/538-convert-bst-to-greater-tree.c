#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* convertBST(struct TreeNode* root) {
    int sum = 0;
    struct TreeNode* stack[10000];
    int top = -1;
    struct TreeNode* node = root;

    while (node != NULL || top >= 0) {
        while (node != NULL) {
            stack[++top] = node;
            node = node->right;
        }

        node = stack[top--];
        sum += node->val;
        node->val = sum;
        node = node->left;
    }

    return root;
}