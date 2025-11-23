/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* mergeInBetween(struct ListNode* list1, int a, int b, struct ListNode* list2) {
    struct ListNode *prevA = NULL, *nodeB = NULL;
    struct ListNode *current = list1;
    int index = 0;

    while (current) {
        if (index == a - 1) {
            prevA = current;
        }
        if (index == b) {
            nodeB = current;
            break;
        }
        current = current->next;
        index++;
    }

    struct ListNode *list2End = list2;
    while (list2End->next) {
        list2End = list2End->next;
    }

    prevA->next = list2;
    list2End->next = nodeB->next;

    return list1;
}