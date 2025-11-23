#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* swapNodes(struct ListNode* head, int k) {
    struct ListNode* first = head;
    struct ListNode* second = head;
    struct ListNode* temp = head;

    for (int i = 0; i < k - 1; i++) {
        first = first->next;
    }

    while (temp->next != NULL) {
        temp = temp->next;
        second = second->next;
    }

    int tempVal = first->val;
    first->val = second->val;
    second->val = tempVal;

    return head;
}