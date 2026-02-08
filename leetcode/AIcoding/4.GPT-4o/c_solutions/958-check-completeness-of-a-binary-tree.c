bool isCompleteBinaryTree(struct TreeNode* root) {
    if (!root) return true;

    struct TreeNode** queue = malloc(10000 * sizeof(struct TreeNode*));
    int head = 0, tail = 0;
    queue[tail++] = root;
    bool end = false;

    while (head < tail) {
        struct TreeNode* node = queue[head++];
        if (!node) {
            end = true;
        } else {
            if (end) return false;
            queue[tail++] = node->left;
            queue[tail++] = node->right;
        }
    }

    free(queue);
    return true;
}