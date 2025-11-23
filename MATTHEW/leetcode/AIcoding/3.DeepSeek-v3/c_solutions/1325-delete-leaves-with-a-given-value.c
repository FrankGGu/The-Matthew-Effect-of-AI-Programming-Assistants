#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* removeLeafNodes(struct TreeNode* root, int target) {
    if (root == NULL) return NULL;

    root->left = removeLeafNodes(root->left, target);
    root->right = removeLeafNodes(root->right, target);

    if (root->left == NULL && root->right == NULL && root->val == target) {
        return NULL;
    }

    return root;
}