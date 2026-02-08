int rangeSumBST(struct TreeNode* root, int low, int high) {
    if (root == NULL) {
        return 0;
    }

    int currentSum = 0;

    if (root->val >= low && root->val <= high) {
        currentSum += root->val;
    }

    if (root->val > low) {
        currentSum += rangeSumBST(root->left, low, high);
    }

    if (root->val < high) {
        currentSum += rangeSumBST(root->right, low, high);
    }

    return currentSum;
}