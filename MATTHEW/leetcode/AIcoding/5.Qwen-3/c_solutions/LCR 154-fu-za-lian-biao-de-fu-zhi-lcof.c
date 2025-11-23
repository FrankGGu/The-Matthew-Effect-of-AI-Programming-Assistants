#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node *next;
    struct Node *random;
} Node;

Node* copyRandomList(Node* head) {
    if (head == NULL) return NULL;

    Node* current = head;
    while (current) {
        Node* new_node = (Node*)malloc(sizeof(Node));
        new_node->val = current->val;
        new_node->next = current->next;
        current->next = new_node;
        current = new_node->next;
    }

    current = head;
    while (current) {
        if (current->random) {
            current->next->random = current->random->next;
        }
        current = current->next->next;
    }

    Node* original = head;
    Node* copy = head->next;
    Node* copy_head = copy;

    while (original) {
        original->next = original->next->next;
        if (copy->next) {
            copy->next = copy->next->next;
        }
        original = original->next;
        copy = copy->next;
    }

    return copy_head;
}