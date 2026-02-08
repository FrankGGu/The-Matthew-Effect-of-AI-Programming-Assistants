/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* doubleIt(struct ListNode* head) {
    struct ListNode* curr = head;
    struct ListNode* prev = NULL;

    while (curr != NULL) {
        struct ListNode* next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }

    struct ListNode* reversed = prev;
    curr = reversed;
    prev = NULL;
    int carry = 0;

    while (curr != NULL) {
        int doubled = curr->val * 2 + carry;
        curr->val = doubled % 10;
        carry = doubled / 10;
        prev = curr;
        curr = curr->next;
    }

    if (carry > 0) {
        struct ListNode* new_node = malloc(sizeof(struct ListNode));
        new_node->val = carry;
        new_node->next = NULL;
        prev->next = new_node;
    }

    curr = reversed;
    prev = NULL;
    while (curr != NULL) {
        struct ListNode* next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }

    return prev;
}