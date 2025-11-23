struct Node* flatten(struct Node* head) {
    if (head == NULL) {
        return NULL;
    }

    struct Node* current = head;

    while (current != NULL) {
        if (current->child != NULL) {
            struct Node* next_node = current->next;
            struct Node* child_head = current->child;

            current->next = child_head;
            child_head->prev = current;
            current->child = NULL;

            struct Node* child_tail = child_head;
            while (child_tail->next != NULL) {
                child_tail = child_tail->next;
            }

            if (next_node != NULL) {
                child_tail->next = next_node;
                next_node->prev = child_tail;
            }
        }
        current = current->next;
    }

    return head;
}