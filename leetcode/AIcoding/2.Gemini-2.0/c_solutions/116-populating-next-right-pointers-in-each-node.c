#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    int val;
    struct Node *left;
    struct Node *right;
    struct Node *next;
};

struct Node* connect(struct Node* root) {
    if (!root) return NULL;

    struct Node* levelStart = root;

    while (levelStart) {
        struct Node* curr = levelStart;
        while (curr) {
            if (curr->left) {
                curr->left->next = curr->right;
            }
            if (curr->right && curr->next) {
                curr->right->next = curr->next->left;
            }
            curr = curr->next;
        }
        levelStart = levelStart->left;
    }

    return root;
}