void inorderTraversalHelper(struct TreeNode* root, int* returnSize, int* result) {
    if (root == NULL) return;
    inorderTraversalHelper(root->left, returnSize, result);
    result[(*returnSize)++] = root->val;
    inorderTraversalHelper(root->right, returnSize, result);
}

int* inorderTraversal(struct TreeNode* root, int* returnSize) {
    int* result = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;
    inorderTraversalHelper(root, returnSize, result);
    return result;
}