#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* partition(struct ListNode* head, int x) {
    struct ListNode less_head, greater_head;
    struct ListNode *less_tail = &less_head, *greater_tail = &greater_head;
    less_head.next = NULL;
    greater_head.next = NULL;

    while (head != NULL) {
        if (head->val < x) {
            less_tail->next = head;
            less_tail = head;
        } else {
            greater_tail->next = head;
            greater_tail = head;
        }
        head = head->next;
    }

    greater_tail->next = NULL;
    less_tail->next = greater_head.next;

    return less_head.next;
}