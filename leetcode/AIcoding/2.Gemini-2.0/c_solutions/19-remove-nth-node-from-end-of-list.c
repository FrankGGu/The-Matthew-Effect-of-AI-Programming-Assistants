#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* removeNthFromEnd(struct ListNode* head, int n){
    struct ListNode *dummy = (struct ListNode *)malloc(sizeof(struct ListNode));
    dummy->next = head;
    dummy->val = 0;
    struct ListNode *fast = dummy;
    struct ListNode *slow = dummy;

    for(int i = 1; i <= n; i++){
        fast = fast->next;
    }

    while(fast->next != NULL){
        fast = fast->next;
        slow = slow->next;
    }

    slow->next = slow->next->next;

    return dummy->next;
}