#include <stdlib.h>

struct ListNode* removeNthFromEnd(struct ListNode* head, int n) {
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = 0; // Value doesn't matter for dummy node
    dummy->next = head;

    struct ListNode* fast = dummy;
    struct ListNode* slow = dummy;

    // Move fast pointer n steps ahead
    for (int i = 0; i < n; i++) {
        fast = fast->next;
    }

    // Move both pointers until fast reaches the end
    // When fast->next is NULL, slow will be at the node before the one to be removed
    while (fast->next != NULL) {
        fast = fast->next;
        slow = slow->next;
    }

    // Remove the Nth node from the end
    struct ListNode* nodeToDelete = slow->next;
    slow->next = slow->next->next;
    free(nodeToDelete); // Free the memory of the removed node

    struct ListNode* newHead = dummy->next;
    free(dummy); // Free the dummy node
    return newHead;
}