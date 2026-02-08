#include <stdlib.h>
#include <stdbool.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

#define MAX_VAL_CONSTRAINT 100001

struct ListNode* deleteNodes(struct ListNode* head, int* nums, int numsSize) {
    bool present_in_array[MAX_VAL_CONSTRAINT] = {false};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= 0 && nums[i] < MAX_VAL_CONSTRAINT) {
            present_in_array[nums[i]] = true;
        }
    }

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prev = &dummy;
    struct ListNode* current = head;

    while (current != NULL) {
        bool should_delete = false;
        if (current->val >= 0 && current->val < MAX_VAL_CONSTRAINT) {
            should_delete = present_in_array[current->val];
        }

        if (should_delete) {
            struct ListNode* temp = current;
            prev->next = current->next;
            current = current->next;
            free(temp);
        } else {
            prev = current;
            current = current->next;
        }
    }

    return dummy.next;
}