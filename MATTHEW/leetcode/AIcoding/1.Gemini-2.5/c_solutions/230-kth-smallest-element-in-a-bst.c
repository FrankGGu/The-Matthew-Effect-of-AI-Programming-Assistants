void inorder_traverse(struct TreeNode* node, int* k_ptr, int* result_ptr) {
    if (node == NULL) {
        return;
    }

    inorder_traverse(node->left, k_ptr, result_ptr);

    if (*k_ptr == 0) {
        return;
    }

    (*k_ptr)--;
    if (*k_ptr == 0) {
        *result_ptr = node->val;
        return;
    }

    inorder_traverse(node->right, k_ptr, result_ptr);
}

int kthSmallest(struct TreeNode* root, int k) {
    int result = 0;
    int k_copy = k;
    inorder_traverse(root, &k_copy, &result);
    return result;
}