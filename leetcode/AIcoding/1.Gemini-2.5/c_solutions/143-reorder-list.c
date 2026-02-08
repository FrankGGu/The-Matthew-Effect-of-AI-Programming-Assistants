struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* curr = head;
    while (curr != NULL) {
        struct ListNode* next_temp = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next_temp;
    }
    return prev;
}

void reorderList(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return;
    }

    struct ListNode* slow = head;
    struct ListNode* fast = head;
    struct ListNode* prev_slow = NULL;

    while (fast != NULL && fast->next != NULL) {
        prev_slow = slow;
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode* head1 = head;
    struct ListNode* head2 = slow;

    if (prev_slow != NULL) {
        prev_slow->next = NULL;
    }

    head2 = reverseList(head2);

    struct ListNode* p1 = head1;
    struct ListNode* p2 = head2;

    while (p1 != NULL && p2 != NULL) {
        struct ListNode* p1_next = p1->next;
        struct ListNode* p2_next = p2->next;

        p1->next = p2;
        p2->next = p1_next;

        p1 = p1_next;
        p2 = p2_next;
    }
}