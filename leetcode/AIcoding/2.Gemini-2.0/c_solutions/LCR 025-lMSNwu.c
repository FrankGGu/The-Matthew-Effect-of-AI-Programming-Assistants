#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
    struct ListNode *stack1 = NULL, *stack2 = NULL;
    struct ListNode *curr = l1;
    while (curr) {
        struct ListNode *temp = (struct ListNode *)malloc(sizeof(struct ListNode));
        temp->val = curr->val;
        temp->next = stack1;
        stack1 = temp;
        curr = curr->next;
    }
    curr = l2;
    while (curr) {
        struct ListNode *temp = (struct ListNode *)malloc(sizeof(struct ListNode));
        temp->val = curr->val;
        temp->next = stack2;
        stack2 = temp;
        curr = curr->next;
    }

    struct ListNode *result = NULL;
    int carry = 0;
    while (stack1 || stack2 || carry) {
        int sum = carry;
        if (stack1) {
            sum += stack1->val;
            struct ListNode *temp = stack1;
            stack1 = stack1->next;
            free(temp);
        }
        if (stack2) {
            sum += stack2->val;
            struct ListNode *temp = stack2;
            stack2 = stack2->next;
            free(temp);
        }
        carry = sum / 10;
        struct ListNode *newNode = (struct ListNode *)malloc(sizeof(struct ListNode));
        newNode->val = sum % 10;
        newNode->next = result;
        result = newNode;
    }

    return result;
}