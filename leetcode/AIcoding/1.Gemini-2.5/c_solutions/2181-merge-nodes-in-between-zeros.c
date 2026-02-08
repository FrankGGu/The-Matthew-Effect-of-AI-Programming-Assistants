struct ListNode* mergeNodes(struct ListNode* head) {
    struct ListNode* read_ptr = head->next;
    struct ListNode* write_ptr = head->next;
    int current_sum = 0;

    while (read_ptr != NULL) {
        if (read_ptr->val == 0) {
            write_ptr->val = current_sum;
            current_sum = 0;
            if (read_ptr->next != NULL) {
                write_ptr->next = read_ptr->next;
                write_ptr = write_ptr->next;
            } else {
                write_ptr->next = NULL;
            }
        } else {
            current_sum += read_ptr->val;
        }
        read_ptr = read_ptr->next;
    }

    return head->next;
}