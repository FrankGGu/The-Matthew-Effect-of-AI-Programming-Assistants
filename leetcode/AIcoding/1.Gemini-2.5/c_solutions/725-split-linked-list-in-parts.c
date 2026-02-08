#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode** splitListToParts(struct ListNode* head, int k, int* returnSize) {
    *returnSize = k;
    struct ListNode** result = (struct ListNode**)malloc(sizeof(struct ListNode*) * k);
    if (result == NULL) {
        return NULL;
    }

    int n = 0;
    struct ListNode* current = head;
    while (current != NULL) {
        n++;
        current = current->next;
    }

    int base_size = n / k;
    int extra_parts = n % k;

    current = head;
    for (int i = 0; i < k; i++) {
        result[i] = current;

        int current_part_size = base_size;
        if (i < extra_parts) {
            current_part_size++;
        }

        if (current_part_size == 0) {
            // All remaining parts will be NULL
            for (int j = i; j < k; j++) {
                result[j] = NULL;
            }
            break;
        }

        // Traverse to the end of the current part
        for (int j = 0; j < current_part_size - 1; j++) {
            if (current != NULL) {
                current = current->next;
            }
        }

        // Detach the current part from the rest of the list
        if (current != NULL) {
            struct ListNode* next_head = current->next;
            current->next = NULL;
            current = next_head;
        }
    }

    return result;
}