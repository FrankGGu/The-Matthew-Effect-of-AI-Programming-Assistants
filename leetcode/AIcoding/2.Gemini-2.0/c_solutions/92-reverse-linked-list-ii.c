#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* reverseBetween(struct ListNode* head, int left, int right){
    if (head == NULL || left == right) {
        return head;
    }

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* pre = &dummy;

    for (int i = 1; i < left; ++i) {
        pre = pre->next;
    }

    struct ListNode* cur = pre->next;
    struct ListNode* next;

    for (int i = 0; i < right - left; ++i) {
        next = cur->next;
        cur->next = next->next;
        next->next = pre->next;
        pre->next = next;
    }

    return dummy.next;
}