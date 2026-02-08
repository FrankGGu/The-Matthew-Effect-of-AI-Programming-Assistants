struct ListNode* deleteDuplicates(struct ListNode* head) {
    struct ListNode dummy;
    struct ListNode* prev = &dummy;
    struct ListNode* curr = head;
    dummy.next = head;

    while (curr) {
        int duplicate = 0;
        while (curr->next && curr->val == curr->next->val) {
            duplicate = 1;
            curr = curr->next;
        }
        if (duplicate) {
            prev->next = curr->next;
        } else {
            prev = prev->next;
        }
        curr = curr->next;
    }
    return dummy.next;
}