struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* current = head;
    while (current != NULL) {
        struct ListNode* next_temp = current->next;
        current->next = prev;
        prev = current;
        current = next_temp;
    }
    return prev;
}