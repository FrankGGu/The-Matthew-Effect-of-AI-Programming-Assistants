int sum = 0;

struct TreeNode* bstToGst(struct TreeNode* root) {
    if (root == NULL) return NULL;
    bstToGst(root->right);
    sum += root->val;
    root->val = sum;
    bstToGst(root->left);
    return root;
}