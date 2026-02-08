void reorderList(struct ListNode* head) {
    if (!head || !head->next) return;

    struct ListNode *slow = head, *fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode *prev = NULL, *curr = slow;
    while (curr) {
        struct ListNode *nextNode = curr->next;
        curr->next = prev;
        prev = curr;
        curr = nextNode;
    }

    struct ListNode *first = head, *second = prev;
    while (second->next) {
        struct ListNode *tmp1 = first->next;
        struct ListNode *tmp2 = second->next;
        first->next = second;
        second->next = tmp1;
        first = tmp1;
        second = tmp2;
    }
}