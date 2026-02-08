struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool checkTree(struct TreeNode* root) {
    if (root == NULL) return false;
    int leftVal = root->left ? root->left->val : 0;
    int rightVal = root->right ? root->right->val : 0;
    return root->val == leftVal + rightVal;
}