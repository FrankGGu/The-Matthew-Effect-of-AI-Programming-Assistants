#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* partition(struct ListNode* head, int x) {
    struct ListNode* lessHead = (struct ListNode*)malloc(sizeof(struct ListNode));
    struct ListNode* greaterHead = (struct ListNode*)malloc(sizeof(struct ListNode));
    struct ListNode* less = lessHead;
    struct ListNode* greater = greaterHead;

    while (head) {
        if (head->val < x) {
            less->next = head;
            less = less->next;
        } else {
            greater->next = head;
            greater = greater->next;
        }
        head = head->next;
    }

    less->next = greaterHead->next;
    greater->next = NULL;

    struct ListNode* result = lessHead->next;
    free(lessHead);
    free(greaterHead);

    return result;
}