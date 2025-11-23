struct ListNode* swapNodes(struct ListNode* head, int k) {
    struct ListNode *node1 = head;
    for (int i = 0; i < k - 1; i++) {
        node1 = node1->next;
    }

    struct ListNode *fast = head;
    struct ListNode *slow = head;
    for (int i = 0; i < k; i++) {
        fast = fast->next;
    }

    while (fast != NULL) {
        slow = slow->next;
        fast = fast->next;
    }
    struct ListNode *node2 = slow;

    int temp = node1->val;
    node1->val = node2->val;
    node2->val = temp;

    return head;
}