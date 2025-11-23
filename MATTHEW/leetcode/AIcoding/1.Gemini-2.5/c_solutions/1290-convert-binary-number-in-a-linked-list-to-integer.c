int getDecimalValue(struct ListNode* head) {
    int result = 0;
    struct ListNode* current = head;

    while (current != NULL) {
        result = (result << 1) | current->val;
        current = current->next;
    }

    return result;
}