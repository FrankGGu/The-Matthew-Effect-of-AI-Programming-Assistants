/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* partition(struct ListNode* head, int x) {
    struct ListNode less_dummy = {0, NULL};
    struct ListNode greater_dummy = {0, NULL};
    struct ListNode *less_ptr = &less_dummy;
    struct ListNode *greater_ptr = &greater_dummy;

    while (head != NULL) {
        if (head->val < x) {
            less_ptr->next = head;
            less_ptr = less_ptr->next;
        } else {
            greater_ptr->next = head;
            greater_ptr = greater_ptr->next;
        }
        head = head->next;
    }

    greater_ptr->next = NULL;
    less_ptr->next = greater_dummy.next;

    return less_dummy.next;
}