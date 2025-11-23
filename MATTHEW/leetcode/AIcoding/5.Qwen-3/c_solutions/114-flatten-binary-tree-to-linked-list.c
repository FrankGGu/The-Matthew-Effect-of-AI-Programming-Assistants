#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

void flatten(struct TreeNode* root) {
    struct TreeNode *current = root;
    while (current) {
        if (current->left) {
            struct TreeNode *prev = current->left;
            while (prev->right) {
                prev = prev->right;
            }
            prev->right = current->right;
            current->right = current->left;
            current->left = NULL;
        }
        current = current->right;
    }
}