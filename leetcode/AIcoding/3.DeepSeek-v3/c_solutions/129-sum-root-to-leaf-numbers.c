int sumNumbersHelper(struct TreeNode* root, int currentSum) {
    if (root == NULL) return 0;

    currentSum = currentSum * 10 + root->val;

    if (root->left == NULL && root->right == NULL) {
        return currentSum;
    }

    return sumNumbersHelper(root->left, currentSum) + sumNumbersHelper(root->right, currentSum);
}

int sumNumbers(struct TreeNode* root) {
    return sumNumbersHelper(root, 0);
}