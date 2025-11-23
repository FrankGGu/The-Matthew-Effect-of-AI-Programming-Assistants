#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* trainingPlan(struct ListNode* head, int* returnSize) {
    int count = 0;
    struct ListNode* current = head;
    while (current != NULL) {
        count++;
        current = current->next;
    }

    int* result = (int*)malloc(count * sizeof(int));
    current = head;
    for (int i = 0; i < count; i++) {
        result[i] = current->val;
        current = current->next;
    }

    *returnSize = count;
    return result;
}