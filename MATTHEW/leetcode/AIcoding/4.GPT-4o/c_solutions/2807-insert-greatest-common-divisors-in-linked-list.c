struct ListNode* insertGreatestCommonDivisors(struct ListNode* head) {
    if (!head) return NULL;

    struct ListNode* current = head;
    while (current->next != NULL) {
        int a = current->val;
        int b = current->next->val;
        int gcd = 1;
        for (int i = 1; i <= a && i <= b; i++) {
            if (a % i == 0 && b % i == 0) {
                gcd = i;
            }
        }

        struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
        newNode->val = gcd;
        newNode->next = current->next;
        current->next = newNode;
        current = newNode->next;
    }

    return head;
}