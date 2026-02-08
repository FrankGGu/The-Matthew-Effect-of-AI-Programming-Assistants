int evaluateTree(struct TreeNode* root) {
    if (root->val == 0) return 0;
    if (root->val == 1) return 1;

    int leftEval = evaluateTree(root->left);
    int rightEval = evaluateTree(root->right);

    return (root->val == 2) ? (leftEval || rightEval) : (leftEval && rightEval);
}