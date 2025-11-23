struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* curr = head;
    while (curr != NULL) {
        struct ListNode* nextTemp = curr->next;
        curr->next = prev;
        prev = curr;
        curr = nextTemp;
    }
    return prev;
}

void reorderList(struct ListNode* head) {
    if (head == NULL || head->next == NULL || head->next->next == NULL) {
        return;
    }

    struct ListNode* slow = head;
    struct ListNode* fast = head->next;

    while (fast != NULL && fast->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode* head1 = head;
    struct ListNode* head2 = slow->next;
    slow->next = NULL;

    head2 = reverseList(head2);

    struct ListNode* current1 = head1;
    struct ListNode* current2 = head2;

    while (current1 != NULL && current2 != NULL) {
        struct ListNode* next1 = current1->next;
        struct ListNode* next2 = current2->next;

        current1->next = current2;
        current2->next = next1;

        current1 = next1;
        current2 = next2;
    }
}