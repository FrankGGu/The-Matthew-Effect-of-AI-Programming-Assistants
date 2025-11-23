/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* mergeNodes(struct ListNode* head) {
    struct ListNode* dummy = malloc(sizeof(struct ListNode));
    struct ListNode* current = dummy;
    int sum = 0;

    head = head->next;

    while (head != NULL) {
        if (head->val == 0) {
            struct ListNode* newNode = malloc(sizeof(struct ListNode));
            newNode->val = sum;
            newNode->next = NULL;
            current->next = newNode;
            current = current->next;
            sum = 0;
        } else {
            sum += head->val;
        }
        head = head->next;
    }

    return dummy->next;
}