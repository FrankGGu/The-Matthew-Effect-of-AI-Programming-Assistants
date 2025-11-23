/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 * struct TreeNode *right;
 * };
 */

struct TreeNode* sufficientSubset(struct TreeNode* root, int limit) {
    if (root == NULL) return NULL;

    if (root->left == NULL && root->right == NULL) {
        if (root->val < limit) {
            return NULL;
        }
        return root;
    }

    root->left = sufficientSubset(root->left, limit - root->val);
    root->right = sufficientSubset(root->right, limit - root->val);

    if (root->left == NULL && root->right == NULL) {
        return NULL;
    }

    return root;
}