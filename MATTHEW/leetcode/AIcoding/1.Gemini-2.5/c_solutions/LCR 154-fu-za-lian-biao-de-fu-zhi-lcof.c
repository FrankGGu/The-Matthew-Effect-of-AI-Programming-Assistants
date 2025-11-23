#include <stdlib.h> // Required for malloc

struct Node {
    int val;
    struct Node *next;
    struct Node *random;
};

struct Node* copyRandomList(struct Node* head) {
    if (head == NULL) {
        return NULL;
    }

    // First pass: Create a copy of each node and insert it right after the original node.
    struct Node* current = head;
    while (current != NULL) {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->val = current->val;
        newNode->next = current->next;
        newNode->random = NULL; // Random pointer will be set in the next pass
        current->next = newNode;
        current = newNode->next;
    }

    // Second pass: Set the random pointers for the copied nodes.
    current = head;
    while (current != NULL) {
        if (current->random != NULL) {
            current->next->random = current->random->next;
        }
        current = current->next->next;
    }

    // Third pass: Separate the original list from the copied list.
    struct Node* newHead = head->next;
    struct Node* originalCurrent = head;
    struct Node* copyCurrent = newHead;

    while (originalCurrent != NULL) {
        originalCurrent->next = copyCurrent->next; // Restore original list's next
        if (copyCurrent->next != NULL) {
            copyCurrent->next = copyCurrent->next->next; // Set copied list's next
        }
        originalCurrent = originalCurrent->next;
        copyCurrent = copyCurrent->next;
    }

    return newHead;
}