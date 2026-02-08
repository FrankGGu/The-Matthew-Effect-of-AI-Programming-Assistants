struct ListNode* deleteMiddle(struct ListNode* head) {
    if (!head || !head->next) return NULL;

    struct ListNode *slow = head, *fast = head, *prev = NULL;

    while (fast && fast->next) {
        prev = slow;
        slow = slow->next;
        fast = fast->next->next;
    }

    prev->next = slow->next;
    free(slow);

    return head;
}