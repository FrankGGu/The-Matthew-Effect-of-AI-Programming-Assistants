#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* current = head;
    struct ListNode* next_node = NULL;
    while (current != NULL) {
        next_node = current->next;
        current->next = prev;
        prev = current;
        current = next_node;
    }
    return prev;
}

struct ListNode* doubleIt(struct ListNode* head) {
    // Reverse the linked list to process digits from least significant to most significant
    struct ListNode* reversed_head = reverseList(head);

    struct ListNode* current = reversed_head;
    struct ListNode* prev = NULL;
    int carry = 0;

    // Iterate through the reversed list, double each digit, and handle carry
    while (current != NULL) {
        int doubled_val = current->val * 2 + carry;
        current->val = doubled_val % 10;
        carry = doubled_val / 10;
        prev = current; // Keep track of the last processed node
        current = current->next;
    }

    // If there's a remaining carry after processing all digits, create a new node for it
    if (carry > 0) {
        struct ListNode* new_node = (struct ListNode*)malloc(sizeof(struct ListNode));
        new_node->val = carry;
        new_node->next = NULL;
        if (prev != NULL) {
            prev->next = new_node;
        } else {
            // This case would only happen if the original list was empty,
            // but problem constraints state at least one node.
            // If original list was [0], prev would be [0], and carry would be 0.
            // So, prev will always be non-NULL here if carry is > 0.
            reversed_head = new_node; // Should not be reached with problem constraints
        }
    }

    // Reverse the list back to its original order to get the final result
    return reverseList(reversed_head);
}