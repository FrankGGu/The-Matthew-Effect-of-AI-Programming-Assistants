struct ListNode** threeEqualParts(struct ListNode* head, int* returnSize) {
    *returnSize = 0;
    struct ListNode *curr = head;
    int total = 0;

    while (curr) {
        total++;
        curr = curr->next;
    }

    if (total % 3 != 0) return NULL;

    int partSize = total / 3;
    struct ListNode *first = head, *second = head, *third = head;

    for (int i = 0; i < partSize; i++) {
        if (first) first = first->next;
    }

    for (int i = 0; i < partSize; i++) {
        if (second) second = second->next;
    }

    for (int i = 0; i < partSize; i++) {
        if (third) third = third->next;
    }

    // Check equality of the parts
    while (third && first && second) {
        if (first->val != second->val || first->val != third->val) return NULL;
        first = first->next;
        second = second->next;
        third = third->next;
    }

    struct ListNode **result = malloc(3 * sizeof(struct ListNode *));

    result[0] = head;
    result[1] = second;
    result[2] = third;

    *returnSize = 3;

    return result;
}