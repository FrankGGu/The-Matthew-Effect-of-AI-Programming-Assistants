struct TreeNode** delNodes(struct TreeNode* root, int* to_delete, int to_deleteSize, int* returnSize) {
    struct TreeNode** forest = malloc(100 * sizeof(struct TreeNode*));
    bool to_delete_map[1001] = { false };
    for (int i = 0; i < to_deleteSize; i++) {
        to_delete_map[to_delete[i]] = true;
    }

    *returnSize = 0;

    struct TreeNode* helper(struct TreeNode* node) {
        if (!node) return NULL;
        bool is_deleted = to_delete_map[node->val];
        if (is_deleted) {
            if (node->left) {
                forest[(*returnSize)++] = helper(node->left);
            }
            if (node->right) {
                forest[(*returnSize)++] = helper(node->right);
            }
            free(node);
            return NULL;
        }
        node->left = helper(node->left);
        node->right = helper(node->right);
        return node;
    }

    if (helper(root)) {
        forest[(*returnSize)++] = root;
    }

    return forest;
}