#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* merge(struct ListNode* list1, struct ListNode* list2) {
    struct ListNode dummy;
    struct ListNode* tail = &dummy;
    dummy.next = NULL;

    while (list1 && list2) {
        if (list1->val < list2->val) {
            tail->next = list1;
            list1 = list1->next;
        } else {
            tail->next = list2;
            list2 = list2->next;
        }
        tail = tail->next;
    }

    if (list1) {
        tail->next = list1;
    } else {
        tail->next = list2;
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

    struct ListNode* list2 = slow->next;
    slow->next = NULL;

    struct ListNode* list1 = sortList(head);
    list2 = sortList(list2);

    return merge(list1, list2);
}