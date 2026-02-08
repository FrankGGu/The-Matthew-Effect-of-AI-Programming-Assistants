/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* deleteNode(struct ListNode* head, int val) {
    if (head == NULL) return NULL;

    if (head->val == val) {
        struct ListNode* newHead = head->next;
        free(head);
        return newHead;
    }

    struct ListNode* prev = head;
    struct ListNode* curr = head->next;

    while (curr != NULL) {
        if (curr->val == val) {
            prev->next = curr->next;
            free(curr);
            break;
        }
        prev = curr;
        curr = curr->next;
    }

    return head;
}