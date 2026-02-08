struct Node* copyRandomList(struct Node* head) {
    if (head == NULL) {
        return NULL;
    }

    struct Node* current = head;
    while (current != NULL) {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->val = current->val;
        newNode->next = current->next;
        current->next = newNode;
        current = newNode->next;
    }

    current = head;
    while (current != NULL) {
        struct Node* copyNode = current->next;
        if (current->random != NULL) {
            copyNode->random = current->random->next;
        } else {
            copyNode->random = NULL;
        }
        current = current->next->next;
    }

    struct Node* newHead = head->next;
    struct Node* original_curr = head;
    struct Node* copy_curr = newHead;

    while (original_curr != NULL) {
        original_curr->next = copy_curr->next;
        if (original_curr->next != NULL) {
            copy_curr->next = original_curr->next->next;
        } else {
            copy_curr->next = NULL;
        }
        original_curr = original_curr->next;
        copy_curr = copy_curr->next;
    }

    return newHead;
}