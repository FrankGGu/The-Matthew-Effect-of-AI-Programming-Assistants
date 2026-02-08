#include <stdio.h>
#include <stdlib.h>

typedef struct TreeLinkNode {
    int val;
    struct TreeLinkNode *left;
    struct TreeLinkNode *right;
    struct TreeLinkNode *next;
} TreeLinkNode;

void connect(struct TreeLinkNode *root) {
    struct TreeLinkNode *current = root;
    while (current) {
        struct TreeLinkNode *dummy = (struct TreeLinkNode *)malloc(sizeof(struct TreeLinkNode));
        struct TreeLinkNode *prev = dummy;
        while (current) {
            if (current->left) {
                prev->next = current->left;
                prev = prev->next;
            }
            if (current->right) {
                prev->next = current->right;
                prev = prev->next;
            }
            current = current->next;
        }
        current = dummy->next;
        free(dummy);
    }
}