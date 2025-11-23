struct TreeNode* deleteNode(struct TreeNode* root, int key) {
    if (!root) return NULL;
    if (key < root->val) {
        root->left = deleteNode(root->left, key);
    } else if (key > root->val) {
        root->right = deleteNode(root->right, key);
    } else {
        if (!root->left) {
            struct TreeNode* rightNode = root->right;
            free(root);
            return rightNode;
        } else if (!root->right) {
            struct TreeNode* leftNode = root->left;
            free(root);
            return leftNode;
        }
        struct TreeNode* minNode = root->right;
        while (minNode->left) {
            minNode = minNode->left;
        }
        root->val = minNode->val;
        root->right = deleteNode(root->right, minNode->val);
    }
    return root;
}