#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

void displayFirstThreeRows(struct ListNode* head) {
    int count = 0;
    struct ListNode* current = head;

    while (current != NULL && count < 3) {
        printf("%d\n", current->val);
        current = current->next;
        count++;
    }
}

int* getFirstThreeValues(struct ListNode* head, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 3);
    *returnSize = 0;
    struct ListNode* current = head;
    int count = 0;

    while (current != NULL && count < 3) {
        result[count] = current->val;
        current = current->next;
        count++;
    }
    *returnSize = count;
    return result;
}

struct ListNode* getFirstThreeNodes(struct ListNode* head) {
    if (head == NULL) return NULL;

    struct ListNode* newHead = (struct ListNode*)malloc(sizeof(struct ListNode));
    newHead->val = head->val;
    newHead->next = NULL;

    struct ListNode* currentOriginal = head->next;
    struct ListNode* currentNew = newHead;
    int count = 1;

    while (currentOriginal != NULL && count < 3) {
        currentNew->next = (struct ListNode*)malloc(sizeof(struct ListNode));
        currentNew = currentNew->next;
        currentNew->val = currentOriginal->val;
        currentNew->next = NULL;

        currentOriginal = currentOriginal->next;
        count++;
    }
    return newHead;
}

void displayFirstThreeRows_C(struct ListNode* head) {
    int count = 0;
    struct ListNode* current = head;

    while (current != NULL && count < 3) {
        // In a typical LeetCode environment, printing to stdout is how "display" is handled
        // unless a specific return format (like an array of strings or integers) is expected.
        printf("%d\n", current->val);
        current = current->next;
        count++;
    }
}