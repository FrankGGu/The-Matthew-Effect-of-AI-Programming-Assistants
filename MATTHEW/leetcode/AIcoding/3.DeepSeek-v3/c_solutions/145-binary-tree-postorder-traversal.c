void postorder(struct TreeNode* root, int* res, int* index) {
    if (root == NULL) return;
    postorder(root->left, res, index);
    postorder(root->right, res, index);
    res[(*index)++] = root->val;
}

int* postorderTraversal(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    if (root == NULL) return NULL;

    int* res = malloc(100 * sizeof(int));
    postorder(root, res, returnSize);
    return res;
}