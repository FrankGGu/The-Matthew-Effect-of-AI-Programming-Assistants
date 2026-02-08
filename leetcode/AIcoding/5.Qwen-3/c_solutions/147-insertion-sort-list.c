#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* insertionSortList(struct ListNode* head) {
    if (!head || !head->next) return head;

    struct ListNode dummy = {0, head};
    struct ListNode *last = head;
    struct ListNode *current = head->next;

    while (current) {
        if (last->val <= current->val) {
            last = current;
            current = current->next;
            continue;
        }

        struct ListNode *prev = &dummy;
        while (prev->next->val < current->val) {
            prev = prev->next;
        }

        struct ListNode *next = current->next;
        current->next = prev->next;
        prev->next = current;
        last->next = next;

        current = next;
    }

    return dummy.next;
}