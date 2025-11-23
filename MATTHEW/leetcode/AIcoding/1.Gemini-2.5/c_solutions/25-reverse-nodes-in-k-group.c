struct ListNode* reverseKGroup(struct ListNode* head, int k) {
    if (head == NULL || k == 1) {
        return head;
    }

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prev_group_end = &dummy; // Points to the node *before* the current k-group

    while (head != NULL) {
        // 1. Check if there are at least k nodes remaining
        struct ListNode* current_group_start = head;
        struct ListNode* next_group_head = head; // Will point to the node *after* the k-group
        int count = 0;
        while (next_group_head != NULL && count < k) {
            next_group_head = next_group_head->next;
            count++;
        }

        if (count < k) { // Not enough nodes to form a k-group
            break;
        }

        // 2. Reverse the k nodes
        // The k nodes are from current_group_start up to the node just before next_group_head.
        // `prev` will become the new head of the reversed group.
        // `current` iterates through the nodes to be reversed.
        // `temp_next` temporarily stores `current->next`.
        struct ListNode* prev = prev_group_end; // This is the node to which the new tail of the reversed group should point
        struct ListNode* current = current_group_start;
        struct ListNode* temp_next = NULL;

        for (int i = 0; i < k; ++i) {
            temp_next = current->next;
            current->next = prev; // Reverse the link
            prev = current;       // Move prev one step forward
            current = temp_next;  // Move current one step forward
        }
        // After this loop:
        // `prev` is the new head of the reversed k-group (originally the k-th node).
        // `current_group_start` is the original head of the k-group, now its tail.
        // `current` is `next_group_head` (the node that was originally after the k-group).

        // 3. Connect the reversed group back to the list
        // The node *before* the k-group (`prev_group_end`) should now point to the new head (`prev`).
        prev_group_end->next = prev;

        // The original head of the k-group (`current_group_start`) is now its tail.
        // Its `next` pointer should point to the head of the next group (`next_group_head`).
        current_group_start->next = next_group_head;

        // 4. Update `prev_group_end` for the next iteration
        // The new `prev_group_end` is the tail of the just-reversed group (`current_group_start`).
        prev_group_end = current_group_start;

        // 5. Update `head` for the next iteration
        // `head` should now point to the start of the next k-group, which is `next_group_head`.
        head = next_group_head;
    }

    return dummy.next;
}