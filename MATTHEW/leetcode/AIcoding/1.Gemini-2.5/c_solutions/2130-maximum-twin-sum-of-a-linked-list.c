int pairSum(struct ListNode* head) {
    struct ListNode *slow = head;
    struct ListNode *fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode *prev = NULL;
    struct ListNode *curr = slow;
    struct ListNode *next_node;
    while (curr) {
        next_node = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next_node;
    }

    struct ListNode *p1 = head;
    struct ListNode *p2 = prev;
    int max_twin_sum = 0;

    while (p2) {
        int current_sum = p1->val + p2->val;
        if (current_sum > max_twin_sum) {
            max_twin_sum = current_sum;
        }
        p1 = p1->next;
        p2 = p2->next;
    }

    return max_twin_sum;
}