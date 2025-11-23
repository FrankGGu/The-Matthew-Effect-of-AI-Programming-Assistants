#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node* flatten(struct Node* head) {
    struct Node* curr = head;
    while (curr) {
        if (curr->child) {
            struct Node* nextNode = curr->next;
            struct Node* childNode = curr->child;
            curr->next = childNode;
            childNode->prev = curr;
            curr->child = NULL;

            struct Node* tail = childNode;
            while (tail->next) {
                tail = tail->next;
            }

            if (nextNode) {
                tail->next = nextNode;
                nextNode->prev = tail;
            }
            curr = childNode;
        } else {
            curr = curr->next;
        }
    }
    return head;
}