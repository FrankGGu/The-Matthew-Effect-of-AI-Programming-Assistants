int calculateSum(struct TreeNode* node, int currentNumber) {
    if (node == NULL) {
        return 0;
    }

    currentNumber = currentNumber * 10 + node->val;

    if (node->left == NULL && node->right == NULL) {
        return currentNumber;
    }

    return calculateSum(node->left, currentNumber) + calculateSum(node->right, currentNumber);
}

int sumNumbers(struct TreeNode* root) {
    return calculateSum(root, 0);
}