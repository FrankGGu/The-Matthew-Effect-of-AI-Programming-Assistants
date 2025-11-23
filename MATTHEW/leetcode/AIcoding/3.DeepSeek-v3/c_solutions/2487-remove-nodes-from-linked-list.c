struct ListNode* removeNodes(struct ListNode* head) {
    if (head == NULL) return NULL;

    head = reverseList(head);

    struct ListNode* current = head;
    struct ListNode* maxNode = head;
    struct ListNode* temp;

    while (current != NULL && current->next != NULL) {
        if (current->next->val < maxNode->val) {
            temp = current->next;
            current->next = temp->next;
            free(temp);
        } else {
            current = current->next;
            maxNode = current;
        }
    }

    return reverseList(head);
}

struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* current = head;
    struct ListNode* next;

    while (current != NULL) {
        next = current->next;
        current->next = prev;
        prev = current;
        current = next;
    }

    return prev;
}