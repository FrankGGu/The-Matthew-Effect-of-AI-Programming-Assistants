#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseKGroup(struct ListNode* head, int k) {
    struct ListNode dummy = {0, head};
    struct ListNode* prev = &dummy;
    struct ListNode* curr = head;
    struct ListNode* next = NULL;
    int count = 0;

    while (curr) {
        count++;
        curr = curr->next;
    }

    curr = head;
    while (count >= k) {
        for (int i = 0; i < k; i++) {
            next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }
        head->next = curr;
        head = prev;
        prev = head;
        count -= k;
    }

    return dummy.next;
}