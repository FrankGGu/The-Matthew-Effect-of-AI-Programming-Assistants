struct ListNode* swapNodes(struct ListNode* head, int k) {
    struct ListNode *first = head, *second = head, *temp = head;
    int length = 0;

    while (temp) {
        length++;
        temp = temp->next;
    }

    for (int i = 1; i < k; i++) {
        first = first->next;
    }

    for (int i = 1; i <= length - k; i++) {
        second = second->next;
    }

    int swap = first->val;
    first->val = second->val;
    second->val = swap;

    return head;
}