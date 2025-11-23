#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* swapNodes(struct ListNode* head, int k){
    struct ListNode* first = NULL;
    struct ListNode* second = NULL;
    struct ListNode* curr = head;
    int count = 1;

    while(curr != NULL){
        if(count == k){
            first = curr;
        }
        curr = curr->next;
        count++;
    }

    curr = head;
    for(int i = 1; i < count - k; i++){
        curr = curr->next;
    }
    second = curr;

    int temp = first->val;
    first->val = second->val;
    second->val = temp;

    return head;
}