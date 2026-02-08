#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* sortList(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return head;
    }

    struct ListNode *slow = head, *fast = head->next;
    while (fast != NULL && fast->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode *head2 = slow->next;
    slow->next = NULL;

    struct ListNode *left = sortList(head);
    struct ListNode *right = sortList(head2);

    struct ListNode dummy;
    struct ListNode *tail = &dummy;

    while (left != NULL && right != NULL) {
        if (left->val < right->val) {
            tail->next = left;
            left = left->next;
        } else {
            tail->next = right;
            right = right->next;
        }
        tail = tail->next;
    }

    if (left != NULL) {
        tail->next = left;
    }

    if (right != NULL) {
        tail->next = right;
    }

    return dummy.next;
}