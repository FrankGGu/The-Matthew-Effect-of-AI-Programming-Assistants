#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

void reorderList(struct ListNode* head) {
    if (!head || !head->next) return;

    struct ListNode *slow = head, *fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode *secondHalf = slow->next;
    slow->next = NULL;

    struct ListNode *prev = NULL, *curr = secondHalf, *next;
    while (curr) {
        next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }

    secondHalf = prev;

    struct ListNode *firstHalf = head;
    while (firstHalf && secondHalf) {
        struct ListNode *temp1 = firstHalf->next;
        struct ListNode *temp2 = secondHalf->next;

        firstHalf->next = secondHalf;
        secondHalf->next = temp1;

        firstHalf = temp1;
        secondHalf = temp2;
    }
}