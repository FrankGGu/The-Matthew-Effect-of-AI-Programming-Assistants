#include <stdio.h>
#include <stdlib.h>

typedef struct ListNode {
    int val;
    struct ListNode *next;
} ListNode;

ListNode* rotateRight(ListNode* head, int k) {
    if (!head || !head->next || k == 0) return head;

    int len = 1;
    ListNode* tail = head;
    while (tail->next) {
        len++;
        tail = tail->next;
    }

    k = k % len;
    if (k == 0) return head;

    int steps = len - k - 1;
    ListNode* curr = head;
    for (int i = 0; i < steps; i++) {
        curr = curr->next;
    }

    ListNode* newHead = curr->next;
    curr->next = NULL;
    tail->next = head;

    return newHead;
}