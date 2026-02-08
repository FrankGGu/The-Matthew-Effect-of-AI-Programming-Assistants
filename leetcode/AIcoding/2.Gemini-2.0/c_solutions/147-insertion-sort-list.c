#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* insertionSortList(struct ListNode* head){
    if (!head || !head->next) return head;

    struct ListNode *dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = -5001;
    dummy->next = head;

    struct ListNode *sortedTail = head;
    struct ListNode *curr = head->next;

    while (curr) {
        if (curr->val >= sortedTail->val) {
            sortedTail = curr;
            curr = curr->next;
        } else {
            struct ListNode *prev = dummy;
            while (prev->next->val <= curr->val) {
                prev = prev->next;
            }

            sortedTail->next = curr->next;
            curr->next = prev->next;
            prev->next = curr;
            curr = sortedTail->next;
        }
    }

    return dummy->next;
}