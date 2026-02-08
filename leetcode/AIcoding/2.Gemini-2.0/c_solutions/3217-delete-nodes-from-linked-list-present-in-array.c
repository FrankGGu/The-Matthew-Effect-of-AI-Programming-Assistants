#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* deleteNodes(struct ListNode* head, int* val, int valSize) {
    bool to_delete[1001] = {false};
    for (int i = 0; i < valSize; i++) {
        to_delete[val[i]] = true;
    }

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode* current = dummy;

    while (current->next != NULL) {
        if (to_delete[current->next->val]) {
            struct ListNode* temp = current->next;
            current->next = current->next->next;
            free(temp);
        } else {
            current = current->next;
        }
    }

    return dummy->next;
}