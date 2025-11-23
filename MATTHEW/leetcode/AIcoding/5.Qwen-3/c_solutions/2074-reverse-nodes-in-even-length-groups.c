#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseEvenLengthGroups(struct ListNode* head) {
    if (!head || !head->next) return head;

    struct ListNode* prev = NULL;
    struct ListNode* curr = head;
    int group = 1;

    while (curr) {
        int length = 0;
        struct ListNode* first = curr;
        struct ListNode* last = curr;
        while (last && length < group) {
            last = last->next;
            length++;
        }

        if (length % 2 == 0) {
            struct ListNode* next = last;
            struct ListNode* prevGroup = prev;
            struct ListNode* p = first;
            struct ListNode* q = p->next;
            for (int i = 0; i < length - 1; i++) {
                struct ListNode* temp = q->next;
                q->next = p;
                p = q;
                q = temp;
            }
            if (prevGroup)
                prevGroup->next = p;
            else
                head = p;
            first->next = next;
            prev = first;
        } else {
            prev = last;
            curr = last;
        }

        group++;
    }

    return head;
}