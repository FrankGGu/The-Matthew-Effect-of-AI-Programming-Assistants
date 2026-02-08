#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void flatten(struct TreeNode* root) {
    if (!root) return;

    flatten(root->left);
    flatten(root->right);

    struct TreeNode* temp = root->right;
    root->right = root->left;
    root->left = NULL;

    struct TreeNode* current = root;
    while (current->right) {
        current = current->right;
    }

    current->right = temp;
}