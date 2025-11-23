/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* expandBinaryTree(struct TreeNode* root){
    if (root == NULL) {
        return NULL;
    }

    if (root->left != NULL) {
        struct TreeNode* newLeft = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newLeft->val = -1;
        newLeft->left = root->left;
        newLeft->right = NULL;
        root->left = newLeft;
        expandBinaryTree(newLeft->left);
    }

    if (root->right != NULL) {
        struct TreeNode* newRight = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newRight->val = -1;
        newRight->left = NULL;
        newRight->right = root->right;
        root->right = newRight;
        expandBinaryTree(newRight->right);
    }

    return root;
}