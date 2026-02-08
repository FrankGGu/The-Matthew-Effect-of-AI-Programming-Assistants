struct ListNode* removeNodes(struct ListNode* head) {
    struct ListNode dummy;
    dummy.next = head;
    struct ListNode *prev = &dummy;

    while (head) {
        if (head->next && head->val < head->next->val) {
            prev->next = head->next;
        } else {
            prev = head;
        }
        head = head->next;
    }

    return dummy.next;
}