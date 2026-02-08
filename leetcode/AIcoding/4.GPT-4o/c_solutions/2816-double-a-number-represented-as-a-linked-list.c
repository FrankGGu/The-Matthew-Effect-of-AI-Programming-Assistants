struct ListNode* doubleIt(struct ListNode* head) {
    struct ListNode *dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    struct ListNode *curr = dummy;
    struct ListNode *prev = NULL;
    int carry = 0;

    while (head) {
        int sum = head->val * 2 + carry;
        carry = sum / 10;
        curr->next = (struct ListNode*)malloc(sizeof(struct ListNode));
        curr = curr->next;
        curr->val = sum % 10;
        head = head->next;
    }

    if (carry) {
        curr->next = (struct ListNode*)malloc(sizeof(struct ListNode));
        curr = curr->next;
        curr->val = carry;
    }

    curr->next = NULL;
    curr = dummy->next;
    free(dummy);

    struct ListNode *reversed = NULL;
    while (curr) {
        struct ListNode *temp = curr->next;
        curr->next = reversed;
        reversed = curr;
        curr = temp;
    }

    return reversed;
}