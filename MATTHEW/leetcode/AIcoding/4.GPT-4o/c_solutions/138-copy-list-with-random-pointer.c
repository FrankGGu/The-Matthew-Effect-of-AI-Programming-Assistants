struct Node* copyRandomList(struct Node* head) {
    if (!head) return NULL;

    struct Node* current = head;
    while (current) {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->val = current->val;
        newNode->next = current->next;
        current->next = newNode;
        current = newNode->next;
    }

    current = head;
    while (current) {
        if (current->random) {
            current->next->random = current->random->next;
        }
        current = current->next->next;
    }

    struct Node* newHead = head->next;
    current = head;
    struct Node* copyCurrent = newHead;

    while (current) {
        current->next = copyCurrent->next;
        current = current->next;
        if (copyCurrent->next) {
            copyCurrent->next = copyCurrent->next->next;
        }
        copyCurrent = copyCurrent->next;
    }

    return newHead;
}