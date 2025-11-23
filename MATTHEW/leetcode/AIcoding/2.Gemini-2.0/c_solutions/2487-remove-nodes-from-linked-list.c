#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* removeNodes(struct ListNode* head) {
    if (!head) return NULL;

    struct ListNode* stack[100000];
    int top = -1;
    struct ListNode* curr = head;

    while (curr) {
        while (top >= 0 && stack[top]->val < curr->val) {
            top--;
        }
        stack[++top] = curr;
        curr = curr->next;
    }

    if (top < 0) return NULL;

    head = stack[0];
    struct ListNode* prev = head;
    for (int i = 1; i <= top; i++) {
        prev->next = stack[i];
        prev = stack[i];
    }
    prev->next = NULL;

    return head;
}