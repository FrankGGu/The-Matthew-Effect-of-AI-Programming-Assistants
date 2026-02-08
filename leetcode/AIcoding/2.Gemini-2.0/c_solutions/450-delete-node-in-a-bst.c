#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode* deleteNode(struct TreeNode* root, int key) {
    if (root == NULL) return root;

    if (key < root->val) {
        root->left = deleteNode(root->left, key);
    } else if (key > root->val) {
        root->right = deleteNode(root->right, key);
    } else {
        if (root->left == NULL) {
            struct TreeNode* temp = root->right;
            free(root);
            return temp;
        } else if (root->right == NULL) {
            struct TreeNode* temp = root->left;
            free(root);
            return temp;
        }

        struct TreeNode* successorParent = root;
        struct TreeNode* successor = root->right;
        while (successor->left != NULL) {
            successorParent = successor;
            successor = successor->left;
        }

        root->val = successor->val;

        if (successorParent != root) {
            successorParent->left = successor->right;
        } else {
            successorParent->right = successor->right;
        }
        free(successor);
    }
    return root;
}