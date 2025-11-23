struct ListNode* reverseKGroup(struct ListNode* head, int k) {
    struct ListNode dummy;
    struct ListNode* prevGroupEnd = &dummy;
    dummy.next = head;

    while (1) {
        struct ListNode* groupStart = prevGroupEnd->next;
        struct ListNode* groupEnd = groupStart;
        for (int i = 0; i < k; i++) {
            if (!groupEnd) return dummy.next;
            groupEnd = groupEnd->next;
        }

        struct ListNode* prev = groupEnd;
        struct ListNode* curr = groupStart;
        for (int i = 0; i < k; i++) {
            struct ListNode* next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }

        prevGroupEnd->next = prev;
        groupStart->next = groupEnd;
        prevGroupEnd = groupStart;
    }
}