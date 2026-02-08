#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

void deleteNode(struct ListNode* node) {
    struct ListNode* nextNode = node->next;
    node->val = nextNode->val;
    node->next = nextNode->next;
    free(nextNode);
}