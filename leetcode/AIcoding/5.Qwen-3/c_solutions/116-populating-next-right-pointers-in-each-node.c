#include <stdio.h>
#include <stdlib.h>

typedef struct TreeLinkNode {
    int val;
    struct TreeLinkNode *left;
    struct TreeLinkNode *right;
    struct TreeLinkNode *next;
} TreeLinkNode;

void connect(struct TreeLinkNode *root) {
    if (!root) return;

    struct TreeLinkNode *levelStart = root;

    while (levelStart) {
        struct TreeLinkNode *current = levelStart;
        while (current) {
            if (current->left) {
                current->left->next = current->right;
            }
            if (current->right) {
                current->right->next = current->next ? current->next->left : NULL;
            }
            current = current->next;
        }
        levelStart = levelStart->left;
    }
}