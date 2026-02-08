#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* head;

struct ListNode* deleteNodes(struct ListNode* head, int* nums, int numsSize) {
    int* hash = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        hash[nums[i]] = 1;
    }

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = -1;
    dummy->next = head;
    struct ListNode* prev = dummy;
    struct ListNode* curr = head;

    while (curr) {
        if (hash[curr->val]) {
            prev->next = curr->next;
            free(curr);
            curr = prev->next;
        } else {
            prev = curr;
            curr = curr->next;
        }
    }

    head = dummy->next;
    free(dummy);
    return head;
}