struct ListNode* mergeInBetween(struct ListNode* list1, int a, int b, struct ListNode* list2) {
    struct ListNode* node_before_a = NULL;
    struct ListNode* node_b = NULL;
    struct ListNode* curr = list1;
    int i = 0;

    while (curr != NULL) {
        if (i == a - 1) {
            node_before_a = curr;
        }
        if (i == b) {
            node_b = curr;
        }
        curr = curr->next;
        i++;
    }

    struct ListNode* tail2 = list2;
    while (tail2->next != NULL) {
        tail2 = tail2->next;
    }

    if (node_before_a == NULL) {
        list1 = list2;
    } else {
        node_before_a->next = list2;
    }

    tail2->next = node_b->next;

    return list1;
}