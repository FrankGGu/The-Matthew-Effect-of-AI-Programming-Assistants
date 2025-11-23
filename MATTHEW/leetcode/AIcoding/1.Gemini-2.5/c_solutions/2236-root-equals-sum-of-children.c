bool isRootEqualsSumChildren(struct TreeNode* root) {
    if (root == NULL) {
        return false; 
    }

    int left_val = (root->left != NULL) ? root->left->val : 0;
    int right_val = (root->right != NULL) ? root->right->val : 0;

    return root->val == (left_val + right_val);
}