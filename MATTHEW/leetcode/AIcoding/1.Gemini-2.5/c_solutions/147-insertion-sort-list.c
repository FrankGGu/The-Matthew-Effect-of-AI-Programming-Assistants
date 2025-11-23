struct ListNode* insertionSortList(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return head;
    }

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = 0;
    dummy->next = NULL;

    struct ListNode* current = head;
    while (current != NULL) {
        struct ListNode* prev_sorted = dummy;
        struct ListNode* next_sorted = dummy->next;

        while (next_sorted != NULL && next_sorted->val < current->val) {
            prev_sorted = next_sorted;
            next_sorted = next_sorted->next;
        }

        struct ListNode* temp = current->next;
        current->next = next_sorted;
        prev_sorted->next = current;
        current = temp;
    }

    struct ListNode* sorted_head = dummy->next;
    free(dummy);
    return sorted_head;
}