#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node* prev;
    struct Node* next;
    struct Node* child;
} Node;

Node* flatten(Node* head) {
    if (!head) return NULL;

    Node* current = head;
    while (current) {
        if (current->child) {
            Node* nextNode = current->next;
            Node* child = current->child;

            current->next = child;
            child->prev = current;

            Node* lastChild = child;
            while (lastChild->next) {
                lastChild = lastChild->next;
            }

            lastChild->next = nextNode;
            if (nextNode) {
                nextNode->prev = lastChild;
            }

            current->child = NULL;
        }
        current = current->next;
    }

    return head;
}