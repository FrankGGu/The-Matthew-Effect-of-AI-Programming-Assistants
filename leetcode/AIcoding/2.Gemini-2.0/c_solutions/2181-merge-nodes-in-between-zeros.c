#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeNodes(struct ListNode* head){
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->next = NULL;
    struct ListNode* tail = dummy;
    struct ListNode* curr = head->next;
    int sum = 0;

    while(curr != NULL){
        if(curr->val == 0){
            struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
            newNode->val = sum;
            newNode->next = NULL;
            tail->next = newNode;
            tail = newNode;
            sum = 0;
        } else {
            sum += curr->val;
        }
        curr = curr->next;
    }

    return dummy->next;
}