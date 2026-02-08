/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* reverseList(struct ListNode* head) {
    struct ListNode* prev = NULL;
    struct ListNode* curr = head;
    while (curr) {
        struct ListNode* next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    return prev;
}

struct ListNode* reverseEvenLengthGroups(struct ListNode* head) {
    if (!head || !head->next) return head;

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prevGroupEnd = &dummy;
    struct ListNode* curr = head;
    int groupLen = 1;

    while (curr) {
        int count = 0;
        struct ListNode* groupStart = curr;
        struct ListNode* prev = NULL;

        while (curr && count < groupLen) {
            prev = curr;
            curr = curr->next;
            count++;
        }

        if (count % 2 == 0) {
            prev->next = NULL;
            struct ListNode* reversedStart = reverseList(groupStart);
            prevGroupEnd->next = reversedStart;
            groupStart->next = curr;
            prevGroupEnd = groupStart;
        } else {
            prevGroupEnd = prev;
        }

        groupLen++;
    }

    return dummy.next;
}