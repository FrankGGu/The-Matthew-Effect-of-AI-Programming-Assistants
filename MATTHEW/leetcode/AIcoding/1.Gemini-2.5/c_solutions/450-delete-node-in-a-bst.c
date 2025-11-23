#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* findMin(struct TreeNode* node) {
    while (node->left != NULL) {
        node = node->left;
    }
    return node;
}

struct TreeNode* deleteNode(struct TreeNode* root, int key) {
    if (root == NULL) {
        return NULL;
    }

    if (key < root->val) {
        root->left = deleteNode(root->left, key);
    } else if (key > root->val) {
        root->right = deleteNode(root->right, key);
    } else {
        // Node to be deleted found

        // Case 1: No child or only one child
        if (root->left == NULL) {
            struct TreeNode* temp = root->right;
            free(root);
            return temp;
        } else if (root->right == NULL) {
            struct TreeNode* temp = root->left;
            free(root);
            return temp;
        }

        // Case 2: Two children
        // Find the in-order successor (smallest in the right subtree)
        struct TreeNode* temp = findMin(root->right);

        // Copy the in-order successor's content to this node
        root->val = temp->val;

        // Delete the in-order successor
        root->right = deleteNode(root->right, temp->val);
    }
    return root;
}