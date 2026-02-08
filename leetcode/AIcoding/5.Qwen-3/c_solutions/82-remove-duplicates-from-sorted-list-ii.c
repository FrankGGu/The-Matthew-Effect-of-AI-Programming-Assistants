#include <stdio.h>
#include <stdlib.h>

struct ListNode* deleteDuplicates(struct ListNode* head) {
    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prev = &dummy;
    struct ListNode* curr = head;

    while (curr) {
        while (curr->next && curr->val == curr->next->val) {
            curr = curr->next;
        }
        if (prev->next != curr) {
            prev->next = curr->next;
        } else {
            prev = curr;
        }
        curr = curr->next;
    }

    return dummy.next;
}