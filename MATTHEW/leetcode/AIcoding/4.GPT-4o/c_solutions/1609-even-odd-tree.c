bool isEvenOddTree(struct TreeNode* root) {
    if (!root) return true;

    struct TreeNode* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    int level = 0;

    while (front < rear) {
        int count = rear - front;
        int last = level % 2 == 0 ? -1 : 101; // For even levels, last is -1; for odd levels, last is 101
        for (int i = 0; i < count; i++) {
            struct TreeNode* node = queue[front++];
            if ((level % 2 == 0 && (node->val % 2 == 0 || node->val <= last)) ||
                (level % 2 == 1 && (node->val % 2 != 0 || node->val >= last))) {
                return false;
            }
            last = node->val;
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        level++;
    }

    return true;
}