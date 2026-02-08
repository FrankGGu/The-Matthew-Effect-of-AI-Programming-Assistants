#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
    struct ListNode* reverseL1 = NULL;
    struct ListNode* reverseL2 = NULL;

    while (l1) {
        struct ListNode* temp = (struct ListNode*)malloc(sizeof(struct ListNode));
        temp->val = l1->val;
        temp->next = reverseL1;
        reverseL1 = temp;
        l1 = l1->next;
    }

    while (l2) {
        struct ListNode* temp = (struct ListNode*)malloc(sizeof(struct ListNode));
        temp->val = l2->val;
        temp->next = reverseL2;
        reverseL2 = temp;
        l2 = l2->next;
    }

    struct ListNode* result = NULL;
    int carry = 0;

    while (reverseL1 || reverseL2 || carry) {
        int sum = carry;
        if (reverseL1) {
            sum += reverseL1->val;
            reverseL1 = reverseL1->next;
        }
        if (reverseL2) {
            sum += reverseL2->val;
            reverseL2 = reverseL2->next;
        }
        carry = sum / 10;
        struct ListNode* node = (struct ListNode*)malloc(sizeof(struct ListNode));
        node->val = sum % 10;
        node->next = result;
        result = node;
    }

    return result;
}