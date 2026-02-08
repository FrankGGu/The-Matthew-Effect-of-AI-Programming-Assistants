#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeNodes(struct ListNode* head) {
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    struct ListNode* current = dummy;
    int sum = 0;
    head = head->next;
    while (head) {
        if (head->val == 0) {
            current->next = (struct ListNode*)malloc(sizeof(struct ListNode));
            current = current->next;
            current->val = sum;
            current->next = NULL;
            sum = 0;
        } else {
            sum += head->val;
        }
        head = head->next;
    }
    return dummy->next;
}