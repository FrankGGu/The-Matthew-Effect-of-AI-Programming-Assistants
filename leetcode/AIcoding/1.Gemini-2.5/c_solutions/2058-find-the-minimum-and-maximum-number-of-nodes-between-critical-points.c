#include <stdlib.h>
#include <limits.h>
#include <math.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* findCriticalPoints(struct ListNode* head) {
    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = -1;
    result[1] = -1;

    if (head == NULL || head->next == NULL || head->next->next == NULL) {
        return result;
    }

    struct ListNode* prev = head;
    struct ListNode* curr = head->next;
    int idx = 1; 

    int firstCriticalIdx = -1;
    int lastCriticalIdx = -1;
    int prevCriticalIdx = -1;
    int minDist = INT_MAX;

    while (curr->next != NULL) {
        struct ListNode* next = curr->next;

        int isLocalMin = (curr->val < prev->val && curr->val < next->val);
        int isLocalMax = (curr->val > prev->val && curr->val > next->val);

        if (isLocalMin || isLocalMax) {
            if (firstCriticalIdx == -1) {
                firstCriticalIdx = idx;
            } else {
                minDist = fmin(minDist, idx - prevCriticalIdx);
            }
            prevCriticalIdx = idx;
            lastCriticalIdx = idx;
        }

        prev = curr;
        curr = next;
        idx++;
    }

    if (firstCriticalIdx == -1 || firstCriticalIdx == lastCriticalIdx) {
        return result;
    } else {
        result[0] = minDist;
        result[1] = lastCriticalIdx - firstCriticalIdx;
        return result;
    }
}