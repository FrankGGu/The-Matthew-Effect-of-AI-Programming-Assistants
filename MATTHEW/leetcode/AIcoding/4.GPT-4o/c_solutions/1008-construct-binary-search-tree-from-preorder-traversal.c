struct TreeNode* bstFromPreorder(int* preorder, int preorderSize) {
    if (preorderSize == 0) return NULL;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[0];
    root->left = NULL;
    root->right = NULL;

    int i = 1;
    while (i < preorderSize && preorder[i] < root->val) {
        i++;
    }

    root->left = bstFromPreorder(preorder + 1, i - 1);
    root->right = bstFromPreorder(preorder + i, preorderSize - i);

    return root;
}