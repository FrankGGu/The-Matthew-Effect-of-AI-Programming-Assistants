struct TreeNode* reverseOddLevels(struct TreeNode* root) {
    if (!root) return NULL;
    struct TreeNode* queue[1000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    int level = 0;

    while (front < rear) {
        int size = rear - front;
        int values[size];
        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front++];
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
            if (level % 2 == 1) values[i] = node->val;
        }
        if (level % 2 == 1) {
            for (int i = 0; i < size; i++) {
                struct TreeNode* node = queue[front - size + i];
                node->val = values[size - 1 - i];
            }
        }
        level++;
    }
    return root;
}