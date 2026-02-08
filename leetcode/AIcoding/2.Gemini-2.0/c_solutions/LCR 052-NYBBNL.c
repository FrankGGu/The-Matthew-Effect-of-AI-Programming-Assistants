#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode* increasingBST(struct TreeNode* root){
    struct TreeNode* dummy = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    dummy->left = NULL;
    dummy->right = NULL;
    struct TreeNode* tail = dummy;

    void inorder(struct TreeNode* node) {
        if (node == NULL) return;

        inorder(node->left);

        struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newNode->val = node->val;
        newNode->left = NULL;
        newNode->right = NULL;

        tail->right = newNode;
        tail = newNode;

        inorder(node->right);
    }

    inorder(root);

    struct TreeNode* result = dummy->right;
    free(dummy);
    return result;
}