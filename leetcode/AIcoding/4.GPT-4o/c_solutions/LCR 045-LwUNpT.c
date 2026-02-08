int findBottomLeftValue(struct TreeNode* root) {
    struct TreeNode* queue[10000];
    int front = 0, back = 0;
    int bottomLeftValue = root->val;

    queue[back++] = root;

    while (front < back) {
        int size = back - front;
        bottomLeftValue = queue[front]->val;

        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front++];
            if (node->left) {
                queue[back++] = node->left;
            }
            if (node->right) {
                queue[back++] = node->right;
            }
        }
    }

    return bottomLeftValue;
}