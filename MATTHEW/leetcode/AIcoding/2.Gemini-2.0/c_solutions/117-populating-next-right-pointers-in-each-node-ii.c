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
    if (!root) return root;

    struct Node* current = root;
    while (current) {
        struct Node* dummy = (struct Node*)malloc(sizeof(struct Node));
        dummy->next = NULL;
        struct Node* tail = dummy;

        while (current) {
            if (current->left) {
                tail->next = current->left;
                tail = tail->next;
            }
            if (current->right) {
                tail->next = current->right;
                tail = tail->next;
            }
            current = current->next;
        }

        current = dummy->next;
        free(dummy);
    }

    return root;
}