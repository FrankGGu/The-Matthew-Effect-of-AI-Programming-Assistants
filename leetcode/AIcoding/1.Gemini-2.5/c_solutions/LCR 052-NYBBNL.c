struct TreeNode* newRoot_global;
struct TreeNode* prev_global;

void inorder_and_link(struct TreeNode* node) {
    if (node == NULL) {
        return;
    }
    inorder_and_link(node->left);
    node->left = NULL;
    if (prev_global != NULL) {
        prev_global->right = node;
    } else {
        newRoot_global = node;
    }
    prev_global = node;
    inorder_and_link(node->right);
}

struct TreeNode* increasingBST(struct TreeNode* root) {
    newRoot_global = NULL;
    prev_global = NULL;
    inorder_and_link(root);
    return newRoot_global;
}