/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* removeZeroSumSublists(struct ListNode* head) {
    struct ListNode dummy;
    dummy.next = head;
    struct ListNode* current = &dummy;

    while (current != NULL) {
        int sum = 0;
        struct ListNode* runner = current->next;
        while (runner != NULL) {
            sum += runner->val;
            if (sum == 0) {
                current->next = runner->next;
            }
            runner = runner->next;
        }
        current = current->next;
    }

    return dummy.next;
}