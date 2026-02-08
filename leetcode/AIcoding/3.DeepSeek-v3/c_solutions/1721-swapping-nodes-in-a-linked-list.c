/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* swapNodes(struct ListNode* head, int k) {
    struct ListNode *first = head, *second = head, *fast = head;

    for (int i = 1; i < k; i++) {
        fast = fast->next;
    }
    first = fast;

    while (fast->next != NULL) {
        second = second->next;
        fast = fast->next;
    }

    int temp = first->val;
    first->val = second->val;
    second->val = temp;

    return head;
}