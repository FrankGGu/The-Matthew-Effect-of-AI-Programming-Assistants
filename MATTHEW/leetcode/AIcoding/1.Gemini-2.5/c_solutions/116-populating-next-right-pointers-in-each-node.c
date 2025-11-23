struct Node *connect(struct Node *root) {
    if (root == NULL) {
        return NULL;
    }

    struct Node *leftmost = root;

    while (leftmost->left != NULL) {
        struct Node *current = leftmost;
        while (current != NULL) {
            current->left->next = current->right;
            if (current->next != NULL) {
                current->right->next = current->next->left;
            }
            current = current->next;
        }
        leftmost = leftmost->left;
    }

    return root;
}