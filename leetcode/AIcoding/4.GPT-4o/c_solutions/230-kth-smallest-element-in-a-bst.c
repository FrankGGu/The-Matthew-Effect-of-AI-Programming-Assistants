int countNodes(struct TreeNode* node) {
    if (node == NULL) return 0;
    return 1 + countNodes(node->left) + countNodes(node->right);
}

void inorder(struct TreeNode* root, int* count, int k, int* result) {
    if (root == NULL || *count >= k) return;
    inorder(root->left, count, k, result);
    (*count)++;
    if (*count == k) {
        *result = root->val;
        return;
    }
    inorder(root->right, count, k, result);
}

int kthSmallest(struct TreeNode* root, int k) {
    int count = 0;
    int result = 0;
    inorder(root, &count, k, &result);
    return result;
}