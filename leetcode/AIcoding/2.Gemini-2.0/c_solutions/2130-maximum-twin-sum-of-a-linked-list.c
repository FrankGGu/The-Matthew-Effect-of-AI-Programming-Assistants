#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int pairSum(struct ListNode* head) {
    struct ListNode *slow = head, *fast = head;
    while (fast != NULL && fast->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode *prev = NULL, *curr = slow, *next = NULL;
    while (curr != NULL) {
        next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }

    int maxSum = 0;
    struct ListNode *first = head, *second = prev;
    while (second != NULL) {
        int sum = first->val + second->val;
        if (sum > maxSum) {
            maxSum = sum;
        }
        first = first->next;
        second = second->next;
    }

    return maxSum;
}