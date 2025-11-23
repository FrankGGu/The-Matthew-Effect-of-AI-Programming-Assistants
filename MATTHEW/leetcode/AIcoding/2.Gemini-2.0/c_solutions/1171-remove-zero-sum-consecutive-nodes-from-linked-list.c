#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* removeZeroSumSublists(struct ListNode* head){
    struct ListNode *dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = 0;
    dummy->next = head;

    struct ListNode *curr = dummy;
    while (curr) {
        int sum = 0;
        struct ListNode *temp = curr->next;
        while (temp) {
            sum += temp->val;
            if (sum == 0) {
                curr->next = temp->next;
                break;
            }
            temp = temp->next;
        }
        if (temp == NULL) {
            curr = curr->next;
        } else {
            curr = dummy;
        }
    }

    return dummy->next;
}