#include <stdlib.h> // Required for malloc

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

    while (current != NULL && current->next != NULL) {
        int val1 = current->val;
        int val2 = current->next->val;

        int commonDivisor = gcd(val1, val2);

        struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
        newNode->val = commonDivisor;
        newNode->next = current->next;

        current->next = newNode;

        // Move current to the node after the newly inserted GCD node
        // This ensures the next pair of nodes considered are the original next node
        // and its subsequent node.
        current = newNode->next;
    }

    return head;
}