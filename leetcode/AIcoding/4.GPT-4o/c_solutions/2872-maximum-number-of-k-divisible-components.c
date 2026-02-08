#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int maxKDivisibleComponents(struct ListNode* head, int k) {
    int count = 0;
    struct ListNode* current = head;

    while (current != NULL) {
        if (current->val % k == 0) {
            count++;
        }
        current = current->next;
    }

    return count;
}