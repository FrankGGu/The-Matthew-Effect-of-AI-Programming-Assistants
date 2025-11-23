void inorder(struct TreeNode* root, int* res, int* index) {
    if (root == NULL) return;
    inorder(root->left, res, index);
    res[(*index)++] = root->val;
    inorder(root->right, res, index);
}

int* inorderTraversal(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    if (root == NULL) return NULL;

    int* res = malloc(100 * sizeof(int));
    inorder(root, res, returnSize);
    return res;
}