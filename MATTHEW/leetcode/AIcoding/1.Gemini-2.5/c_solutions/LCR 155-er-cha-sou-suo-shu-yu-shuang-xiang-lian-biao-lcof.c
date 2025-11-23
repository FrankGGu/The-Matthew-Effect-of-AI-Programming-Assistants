static struct Node* head_node;
static struct Node* prev_node;

void inorder_traverse(struct Node* curr) {
    if (curr == NULL) {
        return;
    }

    inorder_traverse(curr->left);

    if (prev_node == NULL) {
        head_node = curr;
    } else {
        prev_node->right = curr;
        curr->left = prev_node;
    }
    prev_node = curr;

    inorder_traverse(curr->right);
}

struct Node* treeToDoublyList(struct Node* root) {
    if (root == NULL) {
        return NULL;
    }

    head_node = NULL;
    prev_node = NULL;

    inorder_traverse(root);

    // Make the list circular
    head_node->left = prev_node;
    prev_node->right = head_node;

    return head_node;
}