/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize) {
    if (preorderSize == 0) return NULL;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[0];

    int idx = 0;
    while (inorder[idx] != preorder[0]) idx++;

    root->left = buildTree(preorder + 1, idx, inorder, idx);
    root->right = buildTree(preorder + 1 + idx, preorderSize - 1 - idx, inorder + idx + 1, inorderSize - 1 - idx);

    return root;
}