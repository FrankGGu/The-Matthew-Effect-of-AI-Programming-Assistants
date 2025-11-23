#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeInBetween(struct ListNode* list1, int a, int b, struct ListNode* list2) {
    struct ListNode* prev_a = NULL;
    struct ListNode* curr = list1;
    struct ListNode* next_b = NULL;
    int count = 0;

    while (curr != NULL) {
        if (count == a - 1) {
            prev_a = curr;
        }
        if (count == b + 1) {
            next_b = curr;
            break;
        }
        curr = curr->next;
        count++;
    }

    curr = list2;
    while (curr->next != NULL) {
        curr = curr->next;
    }

    if (prev_a != NULL) {
        prev_a->next = list2;
    } else {
        list1 = list2;
    }

    curr->next = next_b;

    return list1;
}