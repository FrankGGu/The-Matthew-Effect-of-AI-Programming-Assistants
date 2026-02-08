#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* insert(struct ListNode* head, int insertVal) {
    struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
    newNode->val = insertVal;
    newNode->next = NULL;

    if (head == NULL) {
        newNode->next = newNode;
        return newNode;
    }

    struct ListNode* curr = head;
    struct ListNode* next = head->next;

    while (next != head) {
        if ((insertVal >= curr->val && insertVal <= next->val) ||
            (curr->val > next->val && (insertVal >= curr->val || insertVal <= next->val))) {
            break;
        }
        curr = next;
        next = next->next;
    }

    curr->next = newNode;
    newNode->next = next;

    return head;
}