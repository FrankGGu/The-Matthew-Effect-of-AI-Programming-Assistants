/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* reverseBetween(struct ListNode* head, int left, int right) {
    if (left == right) return head;

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prev = &dummy;

    for (int i = 0; i < left - 1; i++) {
        prev = prev->next;
    }

    struct ListNode* current = prev->next;
    struct ListNode* next = NULL;
    struct ListNode* tail = current;

    for (int i = 0; i < right - left + 1; i++) {
        next = current->next;
        current->next = prev->next;
        prev->next = current;
        current = next;
    }

    tail->next = current;

    return dummy.next;
}