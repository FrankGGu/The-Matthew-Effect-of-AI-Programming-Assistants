int maxLength = 0;

int helper(struct TreeNode* root, int value) {
    if (!root) return 0;
    int leftLength = helper(root->left, root->val);
    int rightLength = helper(root->right, root->val);
    maxLength = fmax(maxLength, leftLength + rightLength);
    return (root->val == value) ? fmax(leftLength, rightLength) + 1 : 0;
}

int longestUnivaluePath(struct TreeNode* root) {
    maxLength = 0;
    helper(root, -1);
    return maxLength;
}