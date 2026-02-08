#include <stdio.h>
#include <stdlib.h>

typedef struct ListNode {
    int val;
    struct ListNode *next;
} ListNode;

ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    ListNode* reverseList(ListNode* head);
    void push(ListNode** head, int val);
    ListNode* createNode(int val);

    ListNode* reversedL1 = reverseList(l1);
    ListNode* reversedL2 = reverseList(l2);

    ListNode* result = NULL;
    int carry = 0;

    while (reversedL1 || reversedL2 || carry) {
        int sum = carry;
        if (reversedL1) {
            sum += reversedL1->val;
            reversedL1 = reversedL1->next;
        }
        if (reversedL2) {
            sum += reversedL2->val;
            reversedL2 = reversedL2->next;
        }
        carry = sum / 10;
        push(&result, sum % 10);
    }

    return reverseList(result);
}

ListNode* reverseList(ListNode* head) {
    ListNode* prev = NULL;
    ListNode* current = head;
    ListNode* next = NULL;

    while (current) {
        next = current->next;
        current->next = prev;
        prev = current;
        current = next;
    }

    return prev;
}

void push(ListNode** head, int val) {
    ListNode* newNode = createNode(val);
    newNode->next = *head;
    *head = newNode;
}

ListNode* createNode(int val) {
    ListNode* node = (ListNode*)malloc(sizeof(ListNode));
    node->val = val;
    node->next = NULL;
    return node;
}