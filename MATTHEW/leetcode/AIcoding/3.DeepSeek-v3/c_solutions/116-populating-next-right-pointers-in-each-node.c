/**
 * Definition for a Node.
 * struct Node {
 *     int val;
 *     struct Node *left;
 *     struct Node *right;
 *     struct Node *next;
 * };
 */

struct Node* connect(struct Node* root) {
    if (root == NULL) return NULL;

    struct Node* leftmost = root;

    while (leftmost->left != NULL) {
        struct Node* head = leftmost;

        while (head != NULL) {
            head->left->next = head->right;

            if (head->next != NULL) {
                head->right->next = head->next->left;
            }

            head = head->next;
        }

        leftmost = leftmost->left;
    }

    return root;
}