#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* removeZeroSumConsecutive(struct ListNode* head) {
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = 0;
    dummy->next = head;
    struct ListNode* current = dummy;
    while (current != NULL) {
        int sum = 0;
        struct ListNode* next_node = current->next;
        while (next_node != NULL) {
            sum += next_node->val;
            if (sum == 0) {
                current->next = next_node->next;
                break;
            }
            next_node = next_node->next;
        }
        if (next_node == NULL) {
            current = current->next;
        } else {
            current = current->next;
        }
    }
    struct ListNode* result = dummy->next;
    free(dummy);
    return result;
}