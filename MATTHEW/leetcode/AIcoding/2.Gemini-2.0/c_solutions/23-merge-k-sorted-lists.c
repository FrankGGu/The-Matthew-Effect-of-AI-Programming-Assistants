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
            struct ListNode* list1 = lists[2 * i];
            struct ListNode* list2 = lists[2 * i + 1];
            struct ListNode* mergedList = NULL;
            struct ListNode* tail = NULL;

            while (list1 != NULL && list2 != NULL) {
                if (list1->val <= list2->val) {
                    if (mergedList == NULL) {
                        mergedList = list1;
                        tail = list1;
                    } else {
                        tail->next = list1;
                        tail = list1;
                    }
                    list1 = list1->next;
                } else {
                    if (mergedList == NULL) {
                        mergedList = list2;
                        tail = list2;
                    } else {
                        tail->next = list2;
                        tail = list2;
                    }
                    list2 = list2->next;
                }
            }

            if (list1 != NULL) {
                if (mergedList == NULL) {
                    mergedList = list1;
                } else {
                    tail->next = list1;
                }
            }

            if (list2 != NULL) {
                if (mergedList == NULL) {
                    mergedList = list2;
                } else {
                    tail->next = list2;
                }
            }
            lists[i] = mergedList;
        }

        if (listsSize % 2 != 0) {
            lists[newSize - 1] = lists[listsSize - 1];
        }
        listsSize = newSize;
    }

    return lists[0];
}