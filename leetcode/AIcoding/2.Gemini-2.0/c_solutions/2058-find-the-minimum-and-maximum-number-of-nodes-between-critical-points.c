#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* nodesBetweenCriticalPoints(struct ListNode* head, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = INT_MAX;
    result[1] = -1;

    if (!head || !head->next || !head->next->next) {
        result[0] = -1;
        result[1] = -1;
        return result;
    }

    int firstCriticalPoint = -1;
    int lastCriticalPoint = -1;
    int prevCriticalPoint = -1;
    int minDistance = INT_MAX;

    struct ListNode* prev = head;
    struct ListNode* curr = head->next;
    int index = 1;

    while (curr->next) {
        if ((curr->val > prev->val && curr->val > curr->next->val) ||
            (curr->val < prev->val && curr->val < curr->next->val)) {
            if (firstCriticalPoint == -1) {
                firstCriticalPoint = index;
            }
            lastCriticalPoint = index;

            if (prevCriticalPoint != -1) {
                int distance = index - prevCriticalPoint;
                if (distance < minDistance) {
                    minDistance = distance;
                }
            }
            prevCriticalPoint = index;
        }

        prev = curr;
        curr = curr->next;
        index++;
    }

    if (firstCriticalPoint == lastCriticalPoint) {
        result[0] = -1;
        result[1] = -1;
    } else {
        result[0] = minDistance;
        result[1] = lastCriticalPoint - firstCriticalPoint;
    }

    return result;
}