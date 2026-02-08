#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* oddEvenList(struct ListNode* head) {
    if (!head || !head->next) {
        return head;
    }

    struct ListNode* oddHead = head;
    struct ListNode* evenHead = head->next;
    struct ListNode* odd = oddHead;
    struct ListNode* even = evenHead;

    while (even && even->next) {
        odd->next = even->next;
        odd = odd->next;
        even->next = odd->next;
        even = even->next;
    }

    odd->next = evenHead;

    return oddHead;
}