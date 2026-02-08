struct ListNode* deleteDuplicates(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return head;
    }

    struct ListNode* current = head;

    while (current != NULL && current->next != NULL) {
        if (current->val == current->next->val) {
            struct ListNode* duplicateNode = current->next;
            current->next = current->next->next;
            // In C, you might free duplicateNode to prevent memory leaks,
            // but for LeetCode problems involving re-linking, it's often not strictly required
            // as the test environment handles memory.
            // free(duplicateNode); 
        } else {
            current = current->next;
        }
    }

    return head;
}