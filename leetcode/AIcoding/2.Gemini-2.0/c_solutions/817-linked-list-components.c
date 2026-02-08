#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int numComponents(struct ListNode* head, int* nums, int numsSize) {
    bool is_in_set[10001] = {false};
    for (int i = 0; i < numsSize; i++) {
        is_in_set[nums[i]] = true;
    }

    int count = 0;
    bool in_component = false;
    while (head != NULL) {
        if (is_in_set[head->val]) {
            if (!in_component) {
                count++;
                in_component = true;
            }
        } else {
            in_component = false;
        }
        head = head->next;
    }

    return count;
}