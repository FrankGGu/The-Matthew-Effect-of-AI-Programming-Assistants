#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode* swapPairs(struct ListNode* head){
    if (!head || !head->next) {
        return head;
    }

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode* prev = dummy;
    struct ListNode* curr = head;

    while (curr && curr->next) {
        struct ListNode* nextPair = curr->next->next;
        struct ListNode* second = curr->next;

        second->next = curr;
        curr->next = nextPair;
        prev->next = second;

        prev = curr;
        curr = nextPair;
    }

    struct ListNode* newHead = dummy->next;
    free(dummy);
    return newHead;
}