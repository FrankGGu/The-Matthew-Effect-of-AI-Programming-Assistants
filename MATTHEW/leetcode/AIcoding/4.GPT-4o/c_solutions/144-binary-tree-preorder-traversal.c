void preorderTraversalHelper(struct TreeNode* root, int** result, int* returnSize) {
    if (root == NULL) {
        return;
    }
    (*result)[(*returnSize)++] = root->val;
    preorderTraversalHelper(root->left, result, returnSize);
    preorderTraversalHelper(root->right, result, returnSize);
}

int* preorderTraversal(struct TreeNode* root, int* returnSize) {
    int* result = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;
    preorderTraversalHelper(root, &result, returnSize);
    return result;
}