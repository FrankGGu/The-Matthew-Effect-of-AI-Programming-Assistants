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

bool isPalindrome(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return true;
    }

    struct ListNode* slow = head;
    struct ListNode* fast = head;

    // Find the middle of the linked list
    // 'slow' will point to the start of the second half
    while (fast != NULL && fast->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
    }

    // If the list has an odd number of elements, advance slow by one
    // so it points to the actual start of the second half (after the middle element)
    if (fast != NULL) {
        slow = slow->next;
    }

    // Reverse the second half of the list
    struct ListNode* secondHalfHead = reverseList(slow);

    // Compare the first half with the reversed second half
    struct ListNode* p1 = head;
    struct ListNode* p2 = secondHalfHead;
    while (p2 != NULL) {
        if (p1->val != p2->val) {
            // Optional: Restore the list here if required, then return false
            return false;
        }
        p1 = p1->next;
        p2 = p2->next;
    }

    // Optional: Restore the list by reversing the second half back and linking it
    // reverseList(secondHalfHead);
    // (This step is not necessary for the problem's correctness check, but good practice)

    return true;
}