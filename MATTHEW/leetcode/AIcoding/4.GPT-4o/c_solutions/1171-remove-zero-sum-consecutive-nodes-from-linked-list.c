struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* removeZeroSumSublists(struct ListNode* head) {
    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* curr = &dummy;
    int sum = 0;
    int prefix[10000] = {0};
    struct ListNode* node[10000] = {NULL};
    int index = 0;

    while (curr) {
        sum += curr->val;
        prefix[index] = sum;
        node[index] = curr;
        index++;
        curr = curr->next;
    }

    for (int i = 0; i < index; i++) {
        for (int j = 0; j < i; j++) {
            if (prefix[i] == prefix[j]) {
                node[j]->next = node[i]->next;
                break;
            }
        }
    }

    return dummy.next;
}