/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* increasingBST(struct TreeNode* root){
    if (root == NULL) return NULL;

    struct TreeNode* newRoot = NULL;
    struct TreeNode* current = NULL;

    void inorder(struct TreeNode* node) {
        if (node == NULL) return;

        inorder(node->left);

        if (newRoot == NULL) {
            newRoot = node;
            current = node;
        } else {
            current->right = node;
            current = node;
            current->left = NULL;
        }

        inorder(node->right);
    }

    inorder(root);

    if (current != NULL) {
        current->left = NULL;
        current->right = NULL;
    }

    return newRoot;
}