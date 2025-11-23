struct Node {
    int val;
    struct Node *prev;
    struct Node *next;
    struct Node *child;
};

struct Node* flatten(struct Node* head) {
    if (!head) return NULL;

    struct Node* curr = head;
    struct Node* tail = head;

    while (tail->next) {
        tail = tail->next;
    }

    while (curr) {
        if (curr->child) {
            struct Node* child = curr->child;
            curr->child = NULL;
            tail->next = child;
            child->prev = curr;

            while (tail->next) {
                tail = tail->next;
            }
        }
        curr = curr->next;
    }

    return head;
}