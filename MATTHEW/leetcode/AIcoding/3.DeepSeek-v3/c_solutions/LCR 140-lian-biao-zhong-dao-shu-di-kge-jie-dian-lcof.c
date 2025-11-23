/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

struct ListNode* trainingPlan(struct ListNode* head, int cnt) {
    struct ListNode *fast = head, *slow = head;
    for (int i = 0; i < cnt; i++) {
        fast = fast->next;
    }
    while (fast != NULL) {
        fast = fast->next;
        slow = slow->next;
    }
    return slow;
}