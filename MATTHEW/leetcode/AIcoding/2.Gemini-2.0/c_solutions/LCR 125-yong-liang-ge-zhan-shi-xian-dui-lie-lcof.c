#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int val;
    int size;
    struct Node* left;
    struct Node* right;
} Node;

Node* newNode(int val) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = val;
    node->size = 1;
    node->left = NULL;
    node->right = NULL;
    return node;
}

int getSize(Node* node) {
    return node == NULL ? 0 : node->size;
}

Node* updateSize(Node* node) {
    node->size = getSize(node->left) + getSize(node->right) + 1;
    return node;
}

Node* rotateRight(Node* y) {
    Node* x = y->left;
    Node* T2 = x->right;

    x->right = y;
    y->left = T2;

    y = updateSize(y);
    x = updateSize(x);

    return x;
}

Node* rotateLeft(Node* x) {
    Node* y = x->right;
    Node* T2 = y->left;

    y->left = x;
    x->right = T2;

    x = updateSize(x);
    y = updateSize(y);

    return y;
}

Node* insert(Node* root, int val, int index) {
    if (root == NULL) {
        return newNode(val);
    }

    int leftSize = getSize(root->left);
    if (index <= leftSize) {
        root->left = insert(root->left, val, index);
    } else {
        root->right = insert(root->right, val, index - leftSize - 1);
    }

    root = updateSize(root);
    return root;
}

int getVal(Node* root, int index) {
    int leftSize = getSize(root->left);
    if (index == leftSize) {
        return root->val;
    } else if (index < leftSize) {
        return getVal(root->left, index);
    } else {
        return getVal(root->right, index - leftSize - 1);
    }
}

void freeTree(Node* root) {
    if (root != NULL) {
        freeTree(root->left);
        freeTree(root->right);
        free(root);
    }
}

int* processQueries(int** queries, int queriesSize, int* queriesColSize, int capacity, int* returnSize) {
    Node* root = NULL;
    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = 0;

    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 1) {
            root = insert(root, queries[i][1], queries[i][2]);
        } else {
            result[*returnSize] = getVal(root, queries[i][1]);
            (*returnSize)++;
        }
    }

    return result;
}