struct ListNode* oddEvenList(struct ListNode* head) {
    if (!head || !head->next) return head;

    struct ListNode *odd = head, *even = head->next;
    struct ListNode *evenHead = even;

    while (even && even->next) {
        odd->next = odd->next->next;
        even->next = even->next->next;
        odd = odd->next;
        even = even->next;
    }
    odd->next = evenHead;

    return head;
}