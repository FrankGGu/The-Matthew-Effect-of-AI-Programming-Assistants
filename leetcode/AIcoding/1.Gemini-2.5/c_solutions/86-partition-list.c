struct ListNode* partition(struct ListNode* head, int x) {
    struct ListNode* lessHead = (struct ListNode*)malloc(sizeof(struct ListNode));
    lessHead->next = NULL;
    struct ListNode* lessTail = lessHead;

    struct ListNode* greaterHead = (struct ListNode*)malloc(sizeof(struct ListNode));
    greaterHead->next = NULL;
    struct ListNode* greaterTail = greaterHead;

    struct ListNode* current = head;
    while (current != NULL) {
        if (current->val < x) {
            lessTail->next = current;
            lessTail = current;
        } else {
            greaterTail->next = current;
            greaterTail = current;
        }
        current = current->next;
    }

    greaterTail->next = NULL;
    lessTail->next = greaterHead->next;

    struct ListNode* result = lessHead->next;
    free(lessHead);
    free(greaterHead);

    return result;
}