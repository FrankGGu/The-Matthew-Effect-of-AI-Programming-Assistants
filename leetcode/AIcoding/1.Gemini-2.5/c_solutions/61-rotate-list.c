struct ListNode* rotateRight(struct ListNode* head, int k) {
    if (head == NULL || head->next == NULL || k == 0) {
        return head;
    }

    // 1. Find the length of the list and the tail node
    struct ListNode* current = head;
    int length = 1;
    while (current->next != NULL) {
        current = current->next;
        length++;
    }
    // 'current' is now the tail of the list

    // 2. Connect the tail to the head to form a circular list
    current->next = head;

    // 3. Calculate the effective k
    // k can be larger than length, so we take modulo
    k = k % length;

    // 4. Find the new tail: it's (length - k - 1) steps from the original head.
    // The new head will be the node after this new tail.
    struct ListNode* new_tail = head;
    for (int i = 0; i < length - k - 1; i++) {
        new_tail = new_tail->next;
    }

    // 5. The node after new_tail is the new head
    struct ListNode* new_head = new_tail->next;

    // 6. Break the circular link by setting the new tail's next to NULL
    new_tail->next = NULL;

    return new_head;
}