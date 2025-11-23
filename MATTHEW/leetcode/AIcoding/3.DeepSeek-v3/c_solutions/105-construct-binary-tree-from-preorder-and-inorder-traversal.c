typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize) {
    if (preorderSize == 0 || inorderSize == 0) return NULL;

    TreeNode* root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = preorder[0];

    int idx = 0;
    while (inorder[idx] != preorder[0]) idx++;

    root->left = buildTree(preorder + 1, idx, inorder, idx);
    root->right = buildTree(preorder + 1 + idx, preorderSize - idx - 1, inorder + idx + 1, inorderSize - idx - 1);

    return root;
}