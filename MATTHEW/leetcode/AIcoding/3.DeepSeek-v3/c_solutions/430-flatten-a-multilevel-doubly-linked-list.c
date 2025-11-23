/**
 * Definition for a Node.
 * struct Node {
 *     int val;
 *     struct Node *prev;
 *     struct Node *next;
 *     struct Node *child;
 * };
 */

struct Node* flatten(struct Node* head) {
    if (!head) return NULL;

    struct Node* curr = head;
    while (curr) {
        if (curr->child) {
            struct Node* next = curr->next;
            struct Node* child = flatten(curr->child);

            curr->next = child;
            child->prev = curr;
            curr->child = NULL;

            while (child->next) {
                child = child->next;
            }

            child->next = next;
            if (next) {
                next->prev = child;
            }

            curr = next;
        } else {
            curr = curr->next;
        }
    }

    return head;
}