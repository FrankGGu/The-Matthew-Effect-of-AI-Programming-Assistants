struct Node {
    int val;
    struct Node *left;
    struct Node *right;
    struct Node *next;
};

struct Node* connect(struct Node* root) {
    if (!root) return NULL;

    struct Node *current = root;
    struct Node *nextLevelHead = NULL;
    struct Node *prev = NULL;

    while (current) {
        while (current) {
            if (current->left) {
                if (prev) prev->next = current->left;
                else nextLevelHead = current->left;
                prev = current->left;
            }
            if (current->right) {
                if (prev) prev->next = current->right;
                else nextLevelHead = current->right;
                prev = current->right;
            }
            current = current->next;
        }
        current = nextLevelHead;
        nextLevelHead = NULL;
        prev = NULL;
    }
    return root;
}