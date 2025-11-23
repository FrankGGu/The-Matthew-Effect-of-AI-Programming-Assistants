#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* treeToDoublyList(TreeNode* root) {
    if (!root) return NULL;

    TreeNode* head = NULL;
    TreeNode* prev = NULL;

    void inorder(TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        if (prev) {
            prev->right = node;
            node->left = prev;
        } else {
            head = node;
        }
        prev = node;
        inorder(node->right);
    }

    inorder(root);
    if (head) {
        head->left = prev;
        prev->right = head;
    }
    return head;
}