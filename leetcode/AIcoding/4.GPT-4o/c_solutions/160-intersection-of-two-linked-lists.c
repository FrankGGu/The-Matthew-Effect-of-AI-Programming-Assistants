struct ListNode* getIntersectionNode(struct ListNode* headA, struct ListNode* headB) {
    if (!headA || !headB) return NULL;

    struct ListNode *a = headA, *b = headB;

    while (a != b) {
        a = (a == NULL) ? headB : a->next;
        b = (b == NULL) ? headA : b->next;
    }

    return a;
}