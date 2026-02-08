#include <stdio.h>
#include <stdlib.h>

typedef struct RandomListNode {
    int label;
    struct RandomListNode *next;
    struct RandomListNode *random;
} RandomListNode;

RandomListNode* copyRandomList(RandomListNode* head) {
    if (!head) return NULL;

    RandomListNode* current = head;
    while (current) {
        RandomListNode* new_node = (RandomListNode*)malloc(sizeof(RandomListNode));
        new_node->label = current->label;
        new_node->next = current->next;
        current->next = new_node;
        current = new_node->next;
    }

    current = head;
    while (current) {
        if (current->random)
            current->next->random = current->random->next;
        current = current->next->next;
    }

    current = head;
    RandomListNode* copy_head = head->next;
    RandomListNode* copy_current = copy_head;

    while (current) {
        current->next = current->next->next;
        if (copy_current->next)
            copy_current->next = copy_current->next->next;
        current = current->next;
        copy_current = copy_current->next;
    }

    return copy_head;
}