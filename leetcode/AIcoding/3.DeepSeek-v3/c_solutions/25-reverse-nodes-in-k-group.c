/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* reverseKGroup(struct ListNode* head, int k) {
    if (head == NULL || k == 1) return head;

    struct ListNode dummy;
    dummy.next = head;
    struct ListNode *prev = &dummy, *curr = head, *next = NULL;
    int count = 0;

    struct ListNode *temp = head;
    while (temp) {
        temp = temp->next;
        count++;
    }

    while (count >= k) {
        curr = prev->next;
        next = curr->next;

        for (int i = 1; i < k; i++) {
            curr->next = next->next;
            next->next = prev->next;
            prev->next = next;
            next = curr->next;
        }

        prev = curr;
        count -= k;
    }

    return dummy.next;
}