struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* curr = head;
    struct ListNode* next_node;
    while (curr != NULL) {
        next_node = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next_node;
    }
    return prev;
}

bool isPalindrome(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return true;
    }

    // Find the middle of the linked list using slow and fast pointers
    struct ListNode* slow = head;
    struct ListNode* fast = head;
    while (fast != NULL && fast->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
    }

    // 'slow' is now the starting node of the second half of the list.
    // If the list has an odd number of nodes, 'slow' points to the middle node.
    // If the list has an even number of nodes, 'slow' points to the first node of the second half.

    // Reverse the second half of the list
    struct ListNode* second_half_reversed = reverseList(slow);

    // Compare the first half with the reversed second half
    struct ListNode* p1 = head;
    struct ListNode* p2 = second_half_reversed;
    bool is_palindrome = true;

    while (p2 != NULL) { // Iterate until the end of the (possibly shorter) reversed second half
        if (p1->val != p2->val) {
            is_palindrome = false;
            break;
        }
        p1 = p1->next;
        p2 = p2->next;
    }

    // Optional: Restore the list to its original state.
    // This is generally not required for LeetCode problems unless specified,
    // as the problem only asks to check for palindrome, not to preserve the list structure.
    // If restoration were needed:
    // reverseList(second_half_reversed); // Re-reverse the second half
    // // Then link it back to the first half's end. This would require tracking the node
    // // before 'slow' during the initial middle-finding phase.

    return is_palindrome;
}