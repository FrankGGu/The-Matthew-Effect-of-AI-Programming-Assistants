#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int score;
} Person;

typedef struct Node {
    Person* person;
    struct Node* left;
    struct Node* right;
    int height;
} Node;

typedef struct {
    Node* root;
} BST;

int max(int a, int b) {
    return (a > b) ? a : b;
}

int getHeight(Node* node) {
    if (node == NULL) return 0;
    return node->height;
}

Node* createNode(Person* person) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->person = person;
    node->left = NULL;
    node->right = NULL;
    node->height = 1;
    return node;
}

Node* rightRotate(Node* y) {
    Node* x = y->left;
    Node* T2 = x->right;

    x->right = y;
    y->left = T2;

    y->height = max(getHeight(y->left), getHeight(y->right)) + 1;
    x->height = max(getHeight(x->left), getHeight(x->right)) + 1;

    return x;
}

Node* leftRotate(Node* x) {
    Node* y = x->right;
    Node* T2 = y->left;

    y->left = x;
    x->right = T2;

    x->height = max(getHeight(x->left), getHeight(x->right)) + 1;
    y->height = max(getHeight(y->left), getHeight(y->right)) + 1;

    return y;
}

int getBalanceFactor(Node* node) {
    if (node == NULL) return 0;
    return getHeight(node->left) - getHeight(node->right);
}

Node* insertNode(Node* node, Person* person) {
    if (node == NULL) return createNode(person);

    if (strcmp(person->name, node->person->name) < 0) {
        node->left = insertNode(node->left, person);
    } else if (strcmp(person->name, node->person->name) > 0) {
        node->right = insertNode(node->right, person);
    } else {
        free(person->name);
        free(person);
        return node;
    }

    node->height = 1 + max(getHeight(node->left), getHeight(node->right));

    int balance = getBalanceFactor(node);

    if (balance > 1 && strcmp(person->name, node->left->person->name) < 0) {
        return rightRotate(node);
    }

    if (balance < -1 && strcmp(person->name, node->right->person->name) > 0) {
        return leftRotate(node);
    }

    if (balance > 1 && strcmp(person->name, node->left->person->name) > 0) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }

    if (balance < -1 && strcmp(person->name, node->right->person->name) < 0) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node;
}

void inorderTraversal(Node* root, char*** result, int* index) {
    if (root == NULL) return;
    inorderTraversal(root->left, result, index);
    (*result)[*index] = strdup(root->person->name);
    (*index)++;
    inorderTraversal(root->right, result, index);
}

char** rankTracker(char** names, int namesSize, int* returnSize) {
    BST* bst = (BST*)malloc(sizeof(BST));
    bst->root = NULL;

    for (int i = 0; i < namesSize; i++) {
        char* name = strdup(names[i]);
        Person* person = (Person*)malloc(sizeof(Person));
        person->name = name;
        person->score = i + 1;
        bst->root = insertNode(bst->root, person);
    }

    char** result = (char**)malloc(namesSize * sizeof(char*));
    int index = 0;
    inorderTraversal(bst->root, &result, &index);
    *returnSize = namesSize;

    return result;
}