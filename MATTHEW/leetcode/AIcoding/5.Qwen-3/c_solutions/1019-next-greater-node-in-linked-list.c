#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* nextLargerDLL(struct ListNode* head, int* returnSize) {
    int size = 0;
    struct ListNode* temp = head;
    while (temp) {
        size++;
        temp = temp->next;
    }

    int* result = (int*)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        result[i] = 0;
    }

    int* stack = (int*)malloc(size * sizeof(int));
    int top = -1;

    temp = head;
    int index = 0;

    while (temp) {
        while (top >= 0 && temp->val > stack[top]) {
            int prevIndex = stack[--top];
            result[prevIndex] = temp->val;
        }

        stack[++top] = index++;
        temp = temp->next;
    }

    free(stack);
    *returnSize = size;
    return result;
}