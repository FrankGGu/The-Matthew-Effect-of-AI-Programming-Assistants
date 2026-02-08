struct ListNode* swapPairs(struct ListNode* head) {
    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prev = &dummy;

    while (prev->next != NULL && prev->next->next != NULL) {
        struct ListNode* node1 = prev->next;
        struct ListNode* node2 = prev->next->next;
        struct ListNode* next_pair = node2->next;

        // Perform the swap
        node2->next = node1;
        node1->next = next_pair;
        prev->next = node2;

        // Move prev to the new position of node1
        prev = node1;
    }

    return dummy.next;
}