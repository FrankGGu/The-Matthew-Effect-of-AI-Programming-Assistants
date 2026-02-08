#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* insertIntoBST(struct TreeNode* root, int val) {
    struct TreeNode* new_node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    new_node->val = val;
    new_node->left = NULL;
    new_node->right = NULL;

    if (root == NULL) {
        return new_node;
    }

    struct TreeNode* current = root;
    struct TreeNode* parent = NULL;

    while (current != NULL) {
        parent = current;
        if (val < current->val) {
            current = current->left;
        } else {
            current = current->right;
        }
    }

    if (val < parent->val) {
        parent->left = new_node;
    } else {
        parent->right = new_node;
    }

    return root;
}