struct ListNode** splitListToParts(struct ListNode* root, int k, int* returnSize) {
    struct ListNode** parts = malloc(k * sizeof(struct ListNode*));
    struct ListNode* current = root;
    int length = 0;

    while (current) {
        length++;
        current = current->next;
    }

    int partSize = length / k;
    int extra = length % k;
    current = root;
    *returnSize = k;

    for (int i = 0; i < k; i++) {
        parts[i] = current;
        int currentPartSize = partSize + (i < extra ? 1 : 0);

        for (int j = 0; j < currentPartSize - 1 && current; j++) {
            current = current->next;
        }

        if (current) {
            struct ListNode* nextPart = current->next;
            current->next = NULL;
            current = nextPart;
        }
    }

    return parts;
}