#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* curr = head;
    while (curr) {
        struct ListNode* nextTemp = curr->next;
        curr->next = prev;
        prev = curr;
        curr = nextTemp;
    }
    return prev;
}

int pairSum(struct ListNode* head) {
    struct ListNode* slow = head;
    struct ListNode* fast = head;
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode* secondHalf = reverseList(slow);
    int maxSum = 0;
    while (secondHalf) {
        maxSum = (head->val + secondHalf->val) > maxSum ? (head->val + secondHalf->val) : maxSum;
        head = head->next;
        secondHalf = secondHalf->next;
    }

    return maxSum;
}