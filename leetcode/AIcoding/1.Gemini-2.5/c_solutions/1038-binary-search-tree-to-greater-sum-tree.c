static int current_sum;

void reverseInorderTraversal(struct TreeNode* node) {
    if (node == NULL) {
        return;
    }

    reverseInorderTraversal(node->right);

    current_sum += node->val;
    node->val = current_sum;

    reverseInorderTraversal(node->left);
}

struct TreeNode* bstToGst(struct TreeNode* root) {
    current_sum = 0;
    reverseInorderTraversal(root);
    return root;
}