#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* getComponents(struct ListNode* head, int* nums, int numsSize, int* returnSize) {
    int* hash = (int*)calloc(10000, sizeof(int));
    for (int i = 0; i < numsSize; ++i) {
        hash[nums[i]] = 1;
    }

    int count = 0;
    int inComponent = 0;

    while (head != NULL) {
        if (hash[head->val]) {
            inComponent = 1;
        } else {
            if (inComponent) {
                count++;
                inComponent = 0;
            }
        }
        head = head->next;
    }

    if (inComponent) {
        count++;
    }

    *returnSize = count;
    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;

    head = head;
    inComponent = 0;
    int start = -1;

    while (head != NULL) {
        if (hash[head->val]) {
            if (!inComponent) {
                start = head->val;
                inComponent = 1;
            }
        } else {
            if (inComponent) {
                result[index++] = start;
                inComponent = 0;
            }
        }
        head = head->next;
    }

    if (inComponent) {
        result[index++] = start;
    }

    return result;
}