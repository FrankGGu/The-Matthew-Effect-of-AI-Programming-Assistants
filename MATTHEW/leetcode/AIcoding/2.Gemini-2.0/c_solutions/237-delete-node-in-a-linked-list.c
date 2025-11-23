#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void deleteNode(struct ListNode* node) {
    node->val = node->next->val;
    node->next = node->next->next;
}