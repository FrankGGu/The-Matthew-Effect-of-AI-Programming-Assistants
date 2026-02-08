int sumEvenGrandparent(struct TreeNode* root) {
    if (!root) {
        return 0;
    }

    int sum = 0;

    // Check if the current node's value is even
    if (root->val % 2 == 0) {
        // If it is, check its grandchildren
        if (root->left) {
            if (root->left->left) {
                sum += root->left->left->val;
            }
            if (root->left->right) {
                sum += root->left->right->val;
            }
        }
        if (root->right) {
            if (root->right->left) {
                sum += root->right->left->val;
            }
            if (root->right->right) {
                sum += root->right->right->val;
            }
        }
    }

    // Recursively call for left and right children
    sum += sumEvenGrandparent(root->left);
    sum += sumEvenGrandparent(root->right);

    return sum;
}