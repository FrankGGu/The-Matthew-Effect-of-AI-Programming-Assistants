struct ListNode* rotateRight(struct ListNode* head, int k) {
    if (!head || !head->next || k == 0) return head;

    struct ListNode *curr = head;
    int length = 1;

    while (curr->next) {
        curr = curr->next;
        length++;
    }

    curr->next = head; // Make the list circular
    k = k % length; // Avoid unnecessary rotations
    int stepsToNewHead = length - k;

    curr = head;
    for (int i = 0; i < stepsToNewHead - 1; i++) {
        curr = curr->next;
    }

    struct ListNode *newHead = curr->next;
    curr->next = NULL; // Break the circle

    return newHead;
}