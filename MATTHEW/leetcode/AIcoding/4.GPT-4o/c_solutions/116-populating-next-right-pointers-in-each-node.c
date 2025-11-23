#include <stdio.h>
#include <stdlib.h>

struct Node {
    int val;
    struct Node *left;
    struct Node *right;
    struct Node *next;
};

void connect(struct Node* root) {
    if (!root) return;
    struct Node* leftmost = root;
    while (leftmost->left) {
        struct Node* head = leftmost;
        while (head) {
            head->left->next = head->right;
            if (head->next) {
                head->right->next = head->next->left;
            }
            head = head->next;
        }
        leftmost = leftmost->left;
    }
}