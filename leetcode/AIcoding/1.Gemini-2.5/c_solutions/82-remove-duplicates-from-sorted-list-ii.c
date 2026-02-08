struct ListNode* deleteDuplicates(struct ListNode* head) {
    if (head == NULL) {
        return NULL;
    }

    struct ListNode dummy;
    dummy.val = 0;
    dummy.next = head;

    struct ListNode* prev = &dummy;
    struct ListNode* current = head;

    while (current != NULL) {
        int duplicate_val = current->val;
        if (current->next != NULL && current->next->val == duplicate_val) {
            // Found duplicates, skip all nodes with this value
            while (current != NULL && current->val == duplicate_val) {
                struct ListNode* temp = current;
                current = current->next;
                // In a real scenario, you might free temp here.
                // For LeetCode, we just adjust pointers.
            }
            prev->next = current; // Link prev to the node after the duplicate sequence
        } else {
            // No duplicates for current node, move both pointers
            prev = current;
            current = current->next;
        }
    }

    return dummy.next;
}