#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* reverseKGroup(struct ListNode* head, int k){
    if (head == NULL || k <= 1) {
        return head;
    }

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode* pre = dummy;
    struct ListNode* cur = head;

    while (cur != NULL) {
        struct ListNode* tail = pre;
        for (int i = 0; i < k; i++) {
            tail = tail->next;
            if (tail == NULL) {
                return dummy->next;
            }
        }

        struct ListNode* nextGroup = tail->next;

        struct ListNode* prev = pre->next;
        struct ListNode* curr = prev->next;
        for (int i = 1; i < k; i++) {
            struct ListNode* temp = curr->next;
            curr->next = prev;
            prev = curr;
            curr = temp;
        }

        pre->next->next = nextGroup;
        struct ListNode* temp = pre->next;
        pre->next = prev;
        pre = temp;
        cur = nextGroup;
    }

    return dummy->next;
}