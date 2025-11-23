int postIndex;

typedef struct TreeNode TreeNode;

TreeNode* buildTreeHelper(int* inorder, int inStart, int inEnd, int* postorder, int postStart, int postEnd) {
    if (inStart > inEnd || postStart > postEnd) return NULL;

    TreeNode* root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = postorder[postEnd];
    root->left = root->right = NULL;

    int inIndex;
    for (inIndex = inStart; inIndex <= inEnd; inIndex++) {
        if (inorder[inIndex] == root->val) break;
    }

    int leftSize = inIndex - inStart;
    int rightSize = inEnd - inIndex;

    root->left = buildTreeHelper(inorder, inStart, inIndex - 1, postorder, postStart, postStart + leftSize - 1);
    root->right = buildTreeHelper(inorder, inIndex + 1, inEnd, postorder, postStart + leftSize, postEnd - 1);

    return root;
}

TreeNode* buildTree(int* inorder, int inorderSize, int* postorder, int postorderSize) {
    if (inorderSize == 0 || postorderSize == 0) return NULL;
    return buildTreeHelper(inorder, 0, inorderSize - 1, postorder, 0, postorderSize - 1);
}