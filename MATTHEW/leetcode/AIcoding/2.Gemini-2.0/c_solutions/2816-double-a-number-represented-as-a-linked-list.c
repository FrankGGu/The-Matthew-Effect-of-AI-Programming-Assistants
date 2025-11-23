#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* doubleIt(struct ListNode* head) {
    struct ListNode* current = head;
    int carry = 0;

    struct ListNode* dummyHead = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummyHead->val = 0;
    dummyHead->next = head;

    struct ListNode* prev = dummyHead;

    while (current != NULL) {
        int doubled = current->val * 2 + carry;
        current->val = doubled % 10;
        carry = doubled / 10;
        prev = current;
        current = current->next;
    }

    if (carry > 0) {
        dummyHead->val = carry;
        return dummyHead;
    } else {
        return dummyHead->next;
    }
}