#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* doubleNum(struct ListNode* head) {
    struct ListNode* newHead = (struct ListNode*)malloc(sizeof(struct ListNode));
    newHead->val = 0;
    newHead->next = NULL;

    struct ListNode* current = head;
    struct ListNode* newCurrent = newHead;

    while (current != NULL) {
        int total = current->val * 2 + newCurrent->val;
        newCurrent->val = total % 10;
        int carry = total / 10;

        if (carry > 0) {
            struct ListNode* nextNode = (struct ListNode*)malloc(sizeof(struct ListNode));
            nextNode->val = carry;
            nextNode->next = NULL;
            newCurrent->next = nextNode;
            newCurrent = nextNode;
        }

        current = current->next;
    }

    return newHead;
}