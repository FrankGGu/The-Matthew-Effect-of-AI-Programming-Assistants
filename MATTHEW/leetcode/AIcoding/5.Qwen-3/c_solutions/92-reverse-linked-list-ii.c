#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseBetween(struct ListNode* head, int m, int n) {
    if (head == NULL || m == n) return head;

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = 0;
    dummy->next = head;
    struct ListNode* prev = dummy;

    for (int i = 1; i < m; i++) {
        prev = prev->next;
    }

    struct ListNode* curr = prev->next;
    struct ListNode* next = NULL;
    struct ListNode* temp = NULL;

    for (int i = 0; i < n - m + 1; i++) {
        next = curr->next;
        curr->next = temp;
        temp = curr;
        curr = next;
    }

    prev->next->next = curr;
    prev->next = temp;

    struct ListNode* result = dummy->next;
    free(dummy);
    return result;
}