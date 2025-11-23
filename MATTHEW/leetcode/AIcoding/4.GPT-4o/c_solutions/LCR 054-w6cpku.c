int sum = 0;

struct TreeNode* convertBST(struct TreeNode* root) {
    if (root == NULL) {
        return NULL;
    }
    convertBST(root->right);
    sum += root->val;
    root->val = sum;
    convertBST(root->left);
    return root;
}