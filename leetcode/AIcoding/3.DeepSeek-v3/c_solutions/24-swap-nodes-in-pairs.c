/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* swapPairs(struct ListNode* head) {
    if (!head || !head->next) return head;

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* prev = &dummy;
    struct ListNode* curr = head;

    while (curr && curr->next) {
        struct ListNode* first = curr;
        struct ListNode* second = curr->next;

        prev->next = second;
        first->next = second->next;
        second->next = first;

        prev = first;
        curr = first->next;
    }

    return dummy.next;
}