struct ListNode* mergeInBetween(struct ListNode* list1, int a, int b, struct ListNode* list2) {
    struct ListNode *prev = list1, *curr = list1;
    for (int i = 0; i < a - 1; i++) {
        prev = prev->next;
    }
    for (int i = 0; i < b; i++) {
        curr = curr->next;
    }
    prev->next = list2;
    while (prev->next) {
        prev = prev->next;
    }
    prev->next = curr;
    return list1;
}