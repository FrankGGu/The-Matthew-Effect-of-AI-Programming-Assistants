/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int sum;

void traverse(struct TreeNode* root) {
    if (root == NULL) return;

    traverse(root->right);
    sum += root->val;
    root->val = sum;
    traverse(root->left);
}

struct TreeNode* convertBST(struct TreeNode* root) {
    sum = 0;
    traverse(root);
    return root;
}