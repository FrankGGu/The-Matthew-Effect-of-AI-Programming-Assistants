int numComponents(struct ListNode* head, int* G, int GSize) {
    int count = 0;
    int inSet[10001] = {0};

    for (int i = 0; i < GSize; i++) {
        inSet[G[i]] = 1;
    }

    struct ListNode* current = head;
    int inComponent = 0;

    while (current) {
        if (inSet[current->val]) {
            if (!inComponent) {
                count++;
                inComponent = 1;
            }
        } else {
            inComponent = 0;
        }
        current = current->next;
    }

    return count;
}