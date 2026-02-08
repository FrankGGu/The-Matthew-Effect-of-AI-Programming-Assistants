int widthOfBinaryTree(struct TreeNode* root) {
    if (!root) return 0;

    int max_width = 0;
    struct TreeNode** queue = malloc(10000 * sizeof(struct TreeNode*));
    int* index = malloc(10000 * sizeof(int));
    int front = 0, rear = 0;

    queue[rear] = root;
    index[rear++] = 0;

    while (front < rear) {
        int size = rear - front;
        int first = index[front];
        int last = index[front + size - 1];
        max_width = max_width > (last - first + 1) ? max_width : (last - first + 1);

        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front];
            int idx = index[front++];
            if (node->left) {
                queue[rear] = node->left;
                index[rear++] = 2 * idx;
            }
            if (node->right) {
                queue[rear] = node->right;
                index[rear++] = 2 * idx + 1;
            }
        }
    }

    free(queue);
    free(index);
    return max_width;
}