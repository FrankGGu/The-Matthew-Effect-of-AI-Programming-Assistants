#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* merge(struct ListNode* left, struct ListNode* right) {
    struct ListNode dummy;
    struct ListNode* tail = &dummy;

    while (left && right) {
        if (left->val < right->val) {
            tail->next = left;
            left = left->next;
        } else {
            tail->next = right;
            right = right->next;
        }
        tail = tail->next;
    }

    if (left) {
        tail->next = left;
    } else {
        tail->next = right;
    }

    return dummy.next;
}

struct ListNode* sortList(struct ListNode* head) {
    if (!head || !head->next) {
        return head;
    }

    struct ListNode* slow = head;
    struct ListNode* fast = head->next;

    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode* right = slow->next;
    slow->next = NULL;

    struct ListNode* left = sortList(head);
    right = sortList(right);

    return merge(left, right);
}