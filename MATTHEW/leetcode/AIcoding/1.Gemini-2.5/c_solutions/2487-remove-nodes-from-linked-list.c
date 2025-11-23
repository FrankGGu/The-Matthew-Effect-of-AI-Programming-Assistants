struct ListNode* removeNodes(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return head;
    }

    struct ListNode* nextProcessedHead = removeNodes(head->next);

    if (head->val < nextProcessedHead->val) {
        return nextProcessedHead;
    } else {
        head->next = nextProcessedHead;
        return head;
    }
}