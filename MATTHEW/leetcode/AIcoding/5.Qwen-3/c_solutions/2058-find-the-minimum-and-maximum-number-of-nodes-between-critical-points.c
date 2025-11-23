#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* nodesBetweenCriticalPoints(struct ListNode* head, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;
    if (!head || !head->next || !head->next->next) {
        result[0] = -1;
        result[1] = -1;
        return result;
    }

    struct ListNode* prev = head;
    struct ListNode* curr = head->next;
    struct ListNode* next = curr->next;

    int first = -1;
    int last = -1;
    int minDist = -1;
    int maxDist = -1;

    int index = 0;

    while (next) {
        if ((curr->val > prev->val && curr->val > next->val) || (curr->val < prev->val && curr->val < next->val)) {
            if (first == -1) {
                first = index;
            } else {
                if (minDist == -1) {
                    minDist = index - last;
                } else {
                    minDist = (index - last) < minDist ? (index - last) : minDist;
                }
                maxDist = index - first;
            }
            last = index;
        }
        prev = curr;
        curr = next;
        next = next->next;
        index++;
    }

    if (first == -1 || last == first) {
        result[0] = -1;
        result[1] = -1;
    } else {
        result[0] = minDist;
        result[1] = maxDist;
    }

    return result;
}