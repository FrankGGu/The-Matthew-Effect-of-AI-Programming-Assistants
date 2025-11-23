#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* current = head;
    struct ListNode* next = NULL;

    while (current != NULL) {
        next = current->next;
        current->next = prev;
        prev = current;
        current = next;
    }

    return prev;
}

int isPalindrome(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return 1;
    }

    struct ListNode* slow = head;
    struct ListNode* fast = head;

    while (fast->next != NULL && fast->next->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
    }

    struct ListNode* secondHalf = reverseList(slow->next);

    struct ListNode* firstHalf = head;

    while (secondHalf != NULL) {
        if (firstHalf->val != secondHalf->val) {
            return 0;
        }
        firstHalf = firstHalf->next;
        secondHalf = secondHalf->next;
    }

    return 1;
}