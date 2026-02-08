/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

struct ListNode* mergeKLists(struct ListNode** lists, int listsSize) {
    if (listsSize == 0) return NULL;

    while (listsSize > 1) {
        int newSize = 0;
        for (int i = 0; i < listsSize; i += 2) {
            if (i + 1 < listsSize) {
                lists[newSize] = mergeTwoLists(lists[i], lists[i + 1]);
            } else {
                lists[newSize] = lists[i];
            }
            newSize++;
        }
        listsSize = newSize;
    }

    return lists[0];
}

struct ListNode* mergeTwoLists(struct ListNode* l1, struct ListNode* l2) {
    struct ListNode dummy;
    struct ListNode* tail = &dummy;
    dummy.next = NULL;

    while (l1 && l2) {
        if (l1->val < l2->val) {
            tail->next = l1;
            l1 = l1->next;
        } else {
            tail->next = l2;
            l2 = l2->next;
        }
        tail = tail->next;
    }

    tail->next = l1 ? l1 : l2;
    return dummy.next;
}