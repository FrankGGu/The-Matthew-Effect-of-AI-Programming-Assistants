struct ListNode* reverseEvenLengthGroups(struct ListNode* head) {
    if (!head) return NULL;

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prevGroupEnd = &dummy;

    int groupSize = 1;
    struct ListNode* current = head;

    while (current) {
        struct ListNode* groupStart = current;
        struct ListNode* prev = NULL;
        int count = 0;

        while (current && count < groupSize) {
            struct ListNode* nextNode = current->next;
            if (count % 2 == 1) {
                current->next = prev;
            }
            prev = current;
            current = nextNode;
            count++;
        }

        if (count % 2 == 0) {
            prevGroupEnd->next = prev;
            groupStart->next = current;
            prevGroupEnd = groupStart;
        } else {
            prevGroupEnd->next = groupStart;
        }

        groupSize++;
    }

    return dummy.next;
}