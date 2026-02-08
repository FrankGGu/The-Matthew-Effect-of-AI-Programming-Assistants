int minDiameter = INT_MAX;

int height(struct TreeNode* root) {
    if (!root) return 0;
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    minDiameter = fmin(minDiameter, leftHeight + rightHeight);
    return fmax(leftHeight, rightHeight) + 1;
}

int findMinDiameter(struct TreeNode* root1, struct TreeNode* root2) {
    minDiameter = INT_MAX;
    height(root1);
    height(root2);
    return minDiameter;
}