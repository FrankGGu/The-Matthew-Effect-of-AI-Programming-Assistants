struct Node* flatten(struct Node* head) {
    if (head == NULL) {
        return NULL;
    }

    struct Node* curr = head;
    while (curr != NULL) {
        if (curr->child != NULL) {
            // Save the next node in the current level's list
            struct Node* next_node = curr->next;

            // Connect current node to its child list
            curr->next = curr->child;
            curr->child->prev = curr;

            // Find the tail of the child list
            struct Node* child_tail = curr->child;
            while (child_tail->next != NULL) {
                child_tail = child_tail->next;
            }

            // Connect the tail of the child list back to the saved next_node
            child_tail->next = next_node;
            if (next_node != NULL) {
                next_node->prev = child_tail;
            }

            // Clear the child pointer as it's now flattened
            curr->child = NULL;
        }
        // Move to the next node in the flattened list
        curr = curr->next;
    }

    return head;
}