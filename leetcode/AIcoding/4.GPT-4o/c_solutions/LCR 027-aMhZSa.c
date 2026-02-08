bool isPalindrome(struct ListNode* head) {
    if (!head || !head->next) return true;

    struct ListNode *slow = head, *fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode *prev = NULL, *temp;
    while (slow) {
        temp = slow->next;
        slow->next = prev;
        prev = slow;
        slow = temp;
    }

    struct ListNode *p1 = head, *p2 = prev;
    while (p2) {
        if (p1->val != p2->val) return false;
        p1 = p1->next;
        p2 = p2->next;
    }

    return true;
}