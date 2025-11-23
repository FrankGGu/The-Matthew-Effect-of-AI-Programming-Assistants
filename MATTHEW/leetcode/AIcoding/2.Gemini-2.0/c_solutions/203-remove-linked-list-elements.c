#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* removeElements(struct ListNode* head, int val){
    struct ListNode *dummy = malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode *curr = dummy;

    while(curr->next != NULL){
        if(curr->next->val == val){
            curr->next = curr->next->next;
        } else {
            curr = curr->next;
        }
    }

    struct ListNode *newHead = dummy->next;
    free(dummy);
    return newHead;
}