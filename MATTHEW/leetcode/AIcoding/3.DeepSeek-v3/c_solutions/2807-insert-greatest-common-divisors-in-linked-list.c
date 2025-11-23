/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

struct ListNode* insertGreatestCommonDivisors(struct ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return head;
    }

    struct ListNode* current = head;
    while (current->next != NULL) {
        int a = current->val;
        int b = current->next->val;
        int gcd_val = gcd(a, b);

        struct ListNode* new_node = (struct ListNode*)malloc(sizeof(struct ListNode));
        new_node->val = gcd_val;
        new_node->next = current->next;
        current->next = new_node;

        current = new_node->next;
    }

    return head;
}