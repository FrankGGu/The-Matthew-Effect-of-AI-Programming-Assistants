#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    int val;
    struct Node *next;
    struct Node *random;
};

struct Node* copyRandomList(struct Node* head) {
    if (!head) return NULL;

    struct Node *curr = head;
    while (curr) {
        struct Node *newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->val = curr->val;
        newNode->next = curr->next;
        newNode->random = NULL;
        curr->next = newNode;
        curr = newNode->next;
    }

    curr = head;
    while (curr) {
        if (curr->random) {
            curr->next->random = curr->random->next;
        }
        curr = curr->next->next;
    }

    curr = head;
    struct Node *newHead = head->next;
    struct Node *newCurr = newHead;
    while (curr) {
        curr->next = newCurr->next;
        curr = curr->next;
        if (curr) {
            newCurr->next = curr->next;
            newCurr = newCurr->next;
        } else {
            newCurr->next = NULL;
        }
    }

    return newHead;
}