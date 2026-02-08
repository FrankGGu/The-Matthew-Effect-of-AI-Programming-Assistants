#include <stdlib.h>

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

    if (root == NULL || val > root->val) {
        newNode->left = root;
        return newNode;
    }

    root->right = insertIntoMaxTree(root->right, val);
    return root;
}