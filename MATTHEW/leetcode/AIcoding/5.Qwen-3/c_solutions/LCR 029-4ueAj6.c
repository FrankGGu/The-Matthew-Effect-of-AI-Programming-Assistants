#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node* next;
} Node;

Node* insert(Node* head, int insertVal) {
    if (head == NULL) {
        Node* new_node = (Node*)malloc(sizeof(Node));
        new_node->val = insertVal;
        new_node->next = new_node;
        return new_node;
    }

    Node* curr = head;
    Node* next = head->next;
    while (next != head) {
        if (curr->val <= insertVal && next->val >= insertVal) {
            break;
        }
        if (curr->val > next->val) {
            if (insertVal >= curr->val || insertVal <= next->val) {
                break;
            }
        }
        curr = next;
        next = next->next;
    }

    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->val = insertVal;
    new_node->next = next;
    curr->next = new_node;

    return head;
}