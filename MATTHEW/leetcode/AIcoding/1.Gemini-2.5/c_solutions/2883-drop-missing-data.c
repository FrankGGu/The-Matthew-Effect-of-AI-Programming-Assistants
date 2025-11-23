#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* dropMissingData(struct ListNode* head) {
    if (head == NULL) {
        return NULL;
    }

    // Handle leading missing nodes
    while (head != NULL && head->val == -1) {
        struct ListNode* temp = head;
        head = head->next;
        free(temp);
    }

    if (head == NULL) {
        return NULL;
    }

    // Handle missing nodes in the middle and at the end
    struct ListNode* current = head;
    while (current != NULL && current->next != NULL) {
        if (current->next->val == -1) {
            struct ListNode* temp = current->next;
            current->next = current->next->next;
            free(temp);
        } else {
            current = current->next;
        }
    }

    return head;
}