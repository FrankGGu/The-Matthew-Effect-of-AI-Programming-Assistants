struct ListNode* insertionSortList(struct ListNode* head) {
    if (!head) return NULL;

    struct ListNode* sorted = NULL;
    struct ListNode* current = head;

    while (current) {
        struct ListNode* next = current->next;
        if (!sorted || sorted->val >= current->val) {
            current->next = sorted;
            sorted = current;
        } else {
            struct ListNode* temp = sorted;
            while (temp->next && temp->next->val < current->val) {
                temp = temp->next;
            }
            current->next = temp->next;
            temp->next = current;
        }
        current = next;
    }

    return sorted;
}