int pairSum(struct ListNode* head) {
    struct ListNode *slow = head, *fast = head;
    int maxSum = 0;

    // Find the midpoint of the linked list
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }

    // Reverse the second half of the linked list
    struct ListNode *prev = NULL, *curr = slow;
    while (curr) {
        struct ListNode *nextTemp = curr->next;
        curr->next = prev;
        prev = curr;
        curr = nextTemp;
    }

    // Calculate the maximum twin sum
    struct ListNode *firstHalf = head;
    struct ListNode *secondHalf = prev;
    while (secondHalf) {
        int currentSum = firstHalf->val + secondHalf->val;
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
        firstHalf = firstHalf->next;
        secondHalf = secondHalf->next;
    }

    return maxSum;
}