struct ListNode* reverseEvenLengthGroups(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return head;
    }

    struct ListNode* current = head;
    struct ListNode* prevTail = NULL; // Tail of the previous group
    int groupNum = 1;

    while (current != NULL) {
        struct ListNode* groupHead = current;
        struct ListNode* groupTail = NULL;
        struct ListNode* nextGroupHead = NULL;
        int groupLength = 0;

        // Find groupTail and nextGroupHead
        struct ListNode* temp = current;
        for (int i = 0; i < groupNum && temp != NULL; ++i) {
            groupTail = temp;
            temp = temp->next;
            groupLength++;
        }
        nextGroupHead = temp;

        if (groupLength % 2 == 0) { // Even length, reverse
            // Reverse sublist from groupHead to groupTail
            struct ListNode* prev_rev = NULL;
            struct ListNode* curr_rev = groupHead;

            // Loop until curr_rev reaches nextGroupHead (which is the node after groupTail)
            while (curr_rev != nextGroupHead) {
                struct ListNode* next_node = curr_rev->next;
                curr_rev->next = prev_rev;
                prev_rev = curr_rev;
                curr_rev = next_node;
            }
            // After reversal:
            // prev_rev is the new head of the reversed group (original groupTail)
            // groupHead is the new tail of the reversed group (original groupHead)

            // Connect previous group's tail to the new head of this reversed group
            if (prevTail != NULL) {
                prevTail->next = prev_rev;
            } else {
                // This handles the case where the very first group is reversed.
                // For this problem, group 1 has length 1 (odd), so this specific branch
                // for updating 'head' will not be hit for the actual first node.
                head = prev_rev; // Update the overall list head if the first group is reversed
            }

            // Connect the new tail of this reversed group to the next group's head
            groupHead->next = nextGroupHead;

            // Update prevTail for the next iteration
            prevTail = groupHead; // The original groupHead is now the tail of the reversed group
        } else { // Odd length, no reversal
            // Connect previous group's tail to the head of this group
            if (prevTail != NULL) {
                prevTail->next = groupHead;
            }
            // The groupHead -> ... -> groupTail -> nextGroupHead connections are already intact.
            // Update prevTail for the next iteration
            prevTail = groupTail; // The original groupTail is the tail of this unreversed group
        }

        current = nextGroupHead;
        groupNum++;
    }

    return head;
}