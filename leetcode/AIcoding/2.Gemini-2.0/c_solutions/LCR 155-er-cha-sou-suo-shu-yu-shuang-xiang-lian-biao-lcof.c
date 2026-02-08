#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    int val;
    struct Node *left;
    struct Node *right;
};

struct Node* first = NULL;
struct Node* last = NULL;

void inOrder(struct Node* root) {
    if (root == NULL) {
        return;
    }

    inOrder(root->left);

    if (last != NULL) {
        last->right = root;
        root->left = last;
    } else {
        first = root;
    }

    last = root;

    inOrder(root->right);
}

struct Node* treeToDoublyList(struct Node* root) {
    if (root == NULL) {
        return NULL;
    }

    first = NULL;
    last = NULL;
    inOrder(root);

    last->right = first;
    first->left = last;

    return first;
}