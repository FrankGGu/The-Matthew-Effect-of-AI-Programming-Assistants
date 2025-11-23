int** levelOrder(struct Node* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    struct Node** queue = (struct Node**)malloc(sizeof(struct Node*) * 10000); // Max nodes
    int head = 0;
    int tail = 0;

    queue[tail++] = root;

    while (head < tail) {
        int level_size = tail - head;
        int* current_level_vals = (int*)malloc(sizeof(int) * level_size);

        for (int i = 0; i < level_size; i++) {
            struct Node* current_node = queue[head++];
            current_level_vals[i] = current_node->val;

            for (int j = 0; j < current_node->numChildren; j++) {
                if (current_node->children[j] != NULL) {
                    queue[tail++] = current_node->children[j];
                }
            }
        }

        *returnSize += 1;
        result = (int**)realloc(result, sizeof(int*) * (*returnSize));
        result[*returnSize - 1] = current_level_vals;

        *returnColumnSizes = (int*)realloc(*returnColumnSizes, sizeof(int) * (*returnSize));
        (*returnColumnSizes)[*returnSize - 1] = level_size;
    }

    free(queue);
    return result;
}