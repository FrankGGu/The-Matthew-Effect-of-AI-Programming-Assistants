#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* insertGreatestCommonDivisors(struct ListNode* head) {
    if (!head || !head->next) return head;

    struct ListNode* current = head;
    while (current && current->next) {
        int gcd_val = __gcd(current->val, current->next->val);
        struct ListNode* new_node = (struct ListNode*)malloc(sizeof(struct ListNode));
        new_node->val = gcd_val;
        new_node->next = current->next;
        current->next = new_node;
        current = new_node->next;
    }
    return head;
}