#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* removeNthFromEnd(struct ListNode* head, int n){
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->next = head;
    dummy->val = 0;

    struct ListNode* slow = dummy;
    struct ListNode* fast = dummy;

    for(int i = 0; i < n + 1; i++){
        if(fast == NULL) return head;
        fast = fast->next;
    }

    while(fast != NULL){
        slow = slow->next;
        fast = fast->next;
    }

    slow->next = slow->next->next;

    return dummy->next;
}