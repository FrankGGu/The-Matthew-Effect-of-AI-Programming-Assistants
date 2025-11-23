/**
 * Definition for a Node.
 * struct Node {
 *     int val;
 *     struct Node *left;
 *     struct Node *right;
 * };
 */

struct Node* prev = NULL;
struct Node* head = NULL;

void inorder(struct Node* node) {
    if (node == NULL) return;

    inorder(node->left);

    if (prev == NULL) {
        head = node;
    } else {
        prev->right = node;
        node->left = prev;
    }
    prev = node;

    inorder(node->right);
}

struct Node* treeToDoublyList(struct Node* root) {
    if (root == NULL) return NULL;

    prev = NULL;
    head = NULL;

    inorder(root);

    head->left = prev;
    prev->right = head;

    return head;
}