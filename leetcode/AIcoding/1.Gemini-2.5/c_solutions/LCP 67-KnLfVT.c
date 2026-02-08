int decorateAndReturnVal(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }

    int leftDecoratedVal = decorateAndReturnVal(node->left);
    int rightDecoratedVal = decorateAndReturnVal(node->right);

    node->val = leftDecoratedVal + rightDecoratedVal;

    return node->val;
}

struct TreeNode* decorateTree(struct TreeNode* root) {
    if (root == NULL) {
        return NULL;
    }
    decorateAndReturnVal(root);
    return root;
}