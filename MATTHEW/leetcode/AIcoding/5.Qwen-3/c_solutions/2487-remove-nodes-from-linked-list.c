#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* removeNodes(struct ListNode* head) {
    if (!head || !head->next) return head;

    struct ListNode* prev = NULL;
    struct ListNode* curr = head;
    struct ListNode* next = head->next;

    while (next) {
        if (curr->val < next->val) {
            if (prev) {
                prev->next = next;
            } else {
                head = next;
            }
            curr = next;
            next = next->next;
        } else {
            prev = curr;
            curr = next;
            next = next->next;
        }
    }

    return head;
}