struct TreeNode* new_head_global;
struct TreeNode* current_tail_global;

void inorder_traverse_and_build(struct TreeNode* node) {
    if (node == NULL) {
        return;
    }

    inorder_traverse_and_build(node->left);

    if (new_head_global == NULL) {
        new_head_global = node;
        current_tail_global = node;
    } else {
        current_tail_global->right = node;
        current_tail_global = node;
    }
    node->left = NULL;

    inorder_traverse_and_build(node->right);
}

struct TreeNode* increasingBST(struct TreeNode* root) {
    new_head_global = NULL;
    current_tail_global = NULL;

    inorder_traverse_and_build(root);

    return new_head_global;
}