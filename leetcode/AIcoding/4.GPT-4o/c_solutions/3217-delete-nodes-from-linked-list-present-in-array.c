struct ListNode* deleteNodes(struct ListNode* head, int* to_delete, int to_deleteSize) {
    if (!head) return NULL;

    int delete_map[1001] = {0};
    for (int i = 0; i < to_deleteSize; i++) {
        delete_map[to_delete[i]] = 1;
    }

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* current = &dummy;

    while (current->next) {
        if (delete_map[current->next->val]) {
            struct ListNode* temp = current->next;
            current->next = current->next->next;
            free(temp);
        } else {
            current = current->next;
        }
    }

    return dummy.next;
}