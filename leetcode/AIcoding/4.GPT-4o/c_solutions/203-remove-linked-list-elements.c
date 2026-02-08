struct ListNode* removeElements(struct ListNode* head, int val) {
    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* current = &dummy;

    while (current->next != NULL) {
        if (current->next->val == val) {
            struct ListNode* to_delete = current->next;
            current->next = current->next->next;
            free(to_delete);
        } else {
            current = current->next;
        }
    }
    return dummy.next;
}