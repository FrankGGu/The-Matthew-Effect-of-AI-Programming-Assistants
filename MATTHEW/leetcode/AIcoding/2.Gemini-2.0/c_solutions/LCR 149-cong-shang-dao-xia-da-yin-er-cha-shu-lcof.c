#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
  int val;
  struct TreeNode *left;
  struct TreeNode *right;
};

int* recordLightDistribution(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int size = 0;
    int* result = (int*)malloc(sizeof(int) * 1000); 

    void inorderTraversal(struct TreeNode* node) {
        if (!node) return;

        inorderTraversal(node->left);
        result[size++] = node->val;
        inorderTraversal(node->right);
    }

    inorderTraversal(root);
    *returnSize = size;
    return result;
}