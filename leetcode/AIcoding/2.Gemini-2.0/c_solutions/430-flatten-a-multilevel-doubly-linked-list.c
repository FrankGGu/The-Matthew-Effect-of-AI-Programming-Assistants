#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node* flatten(struct Node* head) {
    struct Node* curr = head;
    while (curr) {
        if (curr->child) {
            struct Node* nextNode = curr->next;
            struct Node* childHead = curr->child;
            struct Node* childTail = childHead;
            while (childTail->next) {
                childTail = childTail->next;
            }
            curr->next = childHead;
            childHead->prev = curr;
            childTail->next = nextNode;
            if (nextNode) {
                nextNode->prev = childTail;
            }
            curr->child = NULL;
            curr = nextNode ? nextNode : childTail->next;
        } else {
            curr = curr->next;
        }
    }
    return head;
}