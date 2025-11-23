#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseBetween(struct ListNode* head, int left, int right) {
    if (head == NULL || head->next == NULL || left == right) {
        return head;
    }

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = 0;
    dummy->next = head;

    struct ListNode* pre_left = dummy;
    for (int i = 0; i < left - 1; ++i) {
        pre_left = pre_left->next;
    }

    struct ListNode* start_node = pre_left->next;
    struct ListNode* current = start_node->next;
    struct ListNode* prev = start_node;

    for (int i = 0; i < right - left; ++i) {
        struct ListNode* next_node = current->next;
        current->next = prev;
        prev = current;
        current = next_node;
    }

    pre_left->next = prev;
    start_node->next = current;

    struct ListNode* new_head = dummy->next;
    free(dummy);
    return new_head;
}