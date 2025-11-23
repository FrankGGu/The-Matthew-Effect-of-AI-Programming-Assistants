struct Node *connect(struct Node *root) {
    if (root == NULL) {
        return NULL;
    }

    struct Node *level_start = root;

    while (level_start != NULL) {
        struct Node *current = level_start;
        struct Node *prev_child = NULL;
        struct Node *next_level_start = NULL;

        while (current != NULL) {
            if (current->left != NULL) {
                if (prev_child != NULL) {
                    prev_child->next = current->left;
                } else {
                    next_level_start = current->left;
                }
                prev_child = current->left;
            }

            if (current->right != NULL) {
                if (prev_child != NULL) {
                    prev_child->next = current->right;
                } else {
                    next_level_start = current->right;
                }
                prev_child = current->right;
            }
            current = current->next;
        }
        level_start = next_level_start;
    }

    return root;
}