#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode* increasingBST(struct TreeNode* root){
    struct TreeNode* head = NULL;
    struct TreeNode* tail = NULL;

    void inorder(struct TreeNode* node) {
        if (node == NULL) return;

        inorder(node->left);

        struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newNode->val = node->val;
        newNode->left = NULL;
        newNode->right = NULL;

        if (tail == NULL) {
            head = newNode;
            tail = newNode;
        } else {
            tail->right = newNode;
            tail = newNode;
        }

        inorder(node->right);
    }

    inorder(root);

    return head;
}