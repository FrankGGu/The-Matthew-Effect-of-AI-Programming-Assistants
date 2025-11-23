#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeKLists(struct ListNode** lists, int listsSize) {
    if (listsSize == 0) return NULL;
    if (listsSize == 1) return lists[0];

    while (listsSize > 1) {
        int newSize = (listsSize + 1) / 2;
        for (int i = 0; i < listsSize / 2; i++) {
            struct ListNode* l1 = lists[2 * i];
            struct ListNode* l2 = lists[2 * i + 1];
            struct ListNode* head = NULL;
            struct ListNode* tail = NULL;

            while (l1 && l2) {
                if (l1->val < l2->val) {
                    if (!head) {
                        head = l1;
                        tail = l1;
                    } else {
                        tail->next = l1;
                        tail = l1;
                    }
                    l1 = l1->next;
                } else {
                    if (!head) {
                        head = l2;
                        tail = l2;
                    } else {
                        tail->next = l2;
                        tail = l2;
                    }
                    l2 = l2->next;
                }
            }

            if (l1) {
                if (!head) {
                    head = l1;
                } else {
                    tail->next = l1;
                }
            }
            if (l2) {
                if (!head) {
                    head = l2;
                } else {
                    tail->next = l2;
                }
            }
            lists[i] = head;
        }
        if (listsSize % 2 == 1) {
            lists[newSize - 1] = lists[listsSize - 1];
        }
        listsSize = newSize;
    }

    return lists[0];
}