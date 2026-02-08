#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* deleteDuplicates(struct ListNode* head){
    if (!head) return NULL;

    struct ListNode* current = head;

    while (current && current->next) {
        if (current->val == current->next->val) {
            struct ListNode* temp = current->next;
            current->next = current->next->next;
            free(temp);
        } else {
            current = current->next;
        }
    }

    return head;
}