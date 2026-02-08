#include <stdlib.h> // Required for malloc

#define MAX_NODES 100 // Max nodes is 100 based on LeetCode constraints

struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
    int stack1[MAX_NODES];
    int top1 = -1;
    int stack2[MAX_NODES];
    int top2 = -1;

    struct ListNode* current = l1;
    while (current != NULL) {
        stack1[++top1] = current->val;
        current = current->next;
    }

    current = l2;
    while (current != NULL) {
        stack2[++top2] = current->val;
        current = current->next;
    }

    struct ListNode* resultHead = NULL;
    int carry = 0;

    while (top1 >= 0 || top2 >= 0 || carry != 0) {
        int val1 = (top1 >= 0) ? stack1[top1--] : 0;
        int val2 = (top2 >= 0) ? stack2[top2--] : 0;

        int sum = val1 + val2 + carry;
        carry = sum / 10;
        int digit = sum % 10;

        struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
        newNode->val = digit;

        newNode->next = resultHead;
        resultHead = newNode;
    }

    return resultHead;
}