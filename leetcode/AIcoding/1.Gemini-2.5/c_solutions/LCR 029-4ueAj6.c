#include <stdlib.h>

struct Node {
    int val;
    struct Node *next;
};

typedef struct Node Node;

Node* insert(Node* head, int insertVal) {
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->val = insertVal;

    if (head == NULL) {
        newNode->next = newNode;
        return newNode;
    }

    Node *prev = head;
    Node *curr = head->next;

    do {
        if (prev->val <= insertVal && insertVal <= curr->val) {
            break;
        }

        if (prev->val > curr->val && (insertVal >= prev->val || insertVal <= curr->val)) {
            break;
        }

        prev = curr;
        curr = curr->next;
    } while (prev != head);

    prev->next = newNode;
    newNode->next = curr;

    return head;
}