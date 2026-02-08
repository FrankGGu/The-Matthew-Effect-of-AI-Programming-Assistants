struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int index = 0;

bool dfs(struct TreeNode* node, int* preorder, int size) {
    if (!node) return true;
    if (index >= size || node->val != preorder[index++]) return false;
    if (node->left && node->right) {
        bool flipLeft = dfs(node->left, preorder, size);
        bool flipRight = dfs(node->right, preorder, size);
        return flipLeft || flipRight;
    }
    return dfs(node->left, preorder, size) && dfs(node->right, preorder, size);
}

bool flipMatchVoyage(struct TreeNode* root, int* voyage, int voyageSize) {
    index = 0;
    return dfs(root, voyage, voyageSize);
}