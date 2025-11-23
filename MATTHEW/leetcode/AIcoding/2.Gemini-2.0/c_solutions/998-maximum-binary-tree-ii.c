#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* insertIntoMaxTree(struct TreeNode* root, int val) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;

    if (root == NULL) {
        return newNode;
    }

    if (val > root->val) {
        newNode->left = root;
        return newNode;
    }

    struct TreeNode* current = root;
    while (current->right != NULL && current->right->val > val) {
        current = current->right;
    }

    newNode->left = current->right;
    current->right = newNode;

    return root;
}