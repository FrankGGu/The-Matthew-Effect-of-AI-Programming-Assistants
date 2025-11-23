struct ListNode* mergeNodes(struct ListNode* head) {
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    struct ListNode* current = dummy;
    int sum = 0;

    head = head->next; // Skip the first zero

    while (head) {
        if (head->val == 0) {
            if (sum > 0) {
                current->next = (struct ListNode*)malloc(sizeof(struct ListNode));
                current->next->val = sum;
                current = current->next;
                current->next = NULL;
                sum = 0;
            }
        } else {
            sum += head->val;
        }
        head = head->next;
    }

    return dummy->next;
}