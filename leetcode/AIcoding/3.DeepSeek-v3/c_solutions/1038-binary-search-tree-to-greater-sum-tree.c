/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int sum = 0;

void traverse(struct TreeNode* root) {
    if (root == NULL) return;
    traverse(root->right);
    sum += root->val;
    root->val = sum;
    traverse(root->left);
}

struct TreeNode* bstToGst(struct TreeNode* root) {
    sum = 0;
    traverse(root);
    return root;
}