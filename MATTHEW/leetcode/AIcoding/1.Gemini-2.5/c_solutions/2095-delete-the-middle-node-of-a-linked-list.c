#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* deleteMiddle(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return NULL;
    }

    struct ListNode *slow = head;
    struct ListNode *fast = head;
    struct ListNode *prev_slow = NULL;

    while (fast != NULL && fast->next != NULL) {
        prev_slow = slow;
        slow = slow->next;
        fast = fast->next->next;
    }

    if (prev_slow != NULL) {
        prev_slow->next = slow->next;
        free(slow);
    } else {
        // This case should not be reached given the initial check head->next == NULL
        // but for completeness if the problem definition changes or for robustness.
        // If head has only one node, it's handled by the initial check.
        // If head has two nodes, slow points to the second (middle), prev_slow is head.
        // So prev_slow will never be NULL here if head->next != NULL.
    }

    return head;
}