struct ListNode* partition(struct ListNode* head, int x) {
    struct ListNode *less_head = NULL, *less_tail = NULL;
    struct ListNode *greater_head = NULL, *greater_tail = NULL;

    while (head != NULL) {
        if (head->val < x) {
            if (less_head == NULL) {
                less_head = head;
                less_tail = head;
            } else {
                less_tail->next = head;
                less_tail = less_tail->next;
            }
        } else {
            if (greater_head == NULL) {
                greater_head = head;
                greater_tail = head;
            } else {
                greater_tail->next = head;
                greater_tail = greater_tail->next;
            }
        }
        head = head->next;
    }

    if (less_tail != NULL) {
        less_tail->next = greater_head;
    }

    if (greater_tail != NULL) {
        greater_tail->next = NULL;
    }

    return less_head != NULL ? less_head : greater_head;
}