#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeInBetween(struct ListNode* list1, struct ListNode* list2, int a, int b) {
    struct ListNode* prev = NULL;
    struct ListNode* curr = list1;
    int i = 0;

    while (i < a) {
        prev = curr;
        curr = curr->next;
        i++;
    }

    while (i <= b) {
        struct ListNode* temp = curr;
        curr = curr->next;
        free(temp);
        i++;
    }

    if (prev) {
        prev->next = list2;
    } else {
        list1 = list2;
    }

    while (list2->next) {
        list2 = list2->next;
    }

    list2->next = curr;

    return list1;
}