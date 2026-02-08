#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int count;
    char** keys;
    int size;
    int capacity;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct AllOne {
    Node* head;
    Node* tail;
    int size;
    int capacity;
    char** keys;
    int keyCount;
    int maxCount;
    int minCount;
} AllOne;

Node* createNode(int count) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->count = count;
    node->keys = (char**)malloc(10 * sizeof(char*));
    node->size = 0;
    node->capacity = 10;
    node->prev = NULL;
    node->next = NULL;
    return node;
}

AllOne* allOneCreate() {
    AllOne* obj = (AllOne*)malloc(sizeof(AllOne));
    obj->head = createNode(0);
    obj->tail = createNode(0);
    obj->head->next = obj->tail;
    obj->tail->prev = obj->head;
    obj->size = 0;
    obj->capacity = 10;
    obj->keys = (char**)malloc(obj->capacity * sizeof(char*));
    obj->keyCount = 0;
    obj->maxCount = 0;
    obj->minCount = 0;
    return obj;
}

void addKeyToNode(Node* node, char* key) {
    if (node->size >= node->capacity) {
        node->capacity *= 2;
        node->keys = (char**)realloc(node->keys, node->capacity * sizeof(char*));
    }
    node->keys[node->size++] = key;
}

void removeKeyFromNode(Node* node, char* key) {
    for (int i = 0; i < node->size; i++) {
        if (strcmp(node->keys[i], key) == 0) {
            for (int j = i; j < node->size - 1; j++) {
                node->keys[j] = node->keys[j + 1];
            }
            node->size--;
            return;
        }
    }
}

void insertAfter(Node* node, Node* newNode) {
    newNode->next = node->next;
    newNode->prev = node;
    node->next->prev = newNode;
    node->next = newNode;
}

void removeNode(Node* node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
    free(node->keys);
    free(node);
}

void allOneDecrement(AllOne* obj, char* key) {
    int found = 0;
    Node* curr = obj->head->next;
    while (curr != obj->tail) {
        for (int i = 0; i < curr->size; i++) {
            if (strcmp(curr->keys[i], key) == 0) {
                found = 1;
                break;
            }
        }
        if (found) break;
        curr = curr->next;
    }

    if (!found) return;

    removeKeyFromNode(curr, key);

    if (curr->size == 0) {
        removeNode(curr);
    }

    Node* nextNode = curr->next;
    if (nextNode->count == curr->count - 1) {
        addKeyToNode(nextNode, key);
    } else {
        Node* newNode = createNode(curr->count - 1);
        insertAfter(nextNode->prev, newNode);
        addKeyToNode(newNode, key);
    }

    if (obj->minCount == curr->count && curr->size == 0) {
        obj->minCount = nextNode->count;
    }
}

void allOneIncrement(AllOne* obj, char* key) {
    int found = 0;
    Node* curr = obj->head->next;
    while (curr != obj->tail) {
        for (int i = 0; i < curr->size; i++) {
            if (strcmp(curr->keys[i], key) == 0) {
                found = 1;
                break;
            }
        }
        if (found) break;
        curr = curr->next;
    }

    if (found) {
        removeKeyFromNode(curr, key);
        if (curr->size == 0) {
            removeNode(curr);
        }
    }

    Node* nextNode = curr->next;
    if (nextNode->count == curr->count + 1) {
        addKeyToNode(nextNode, key);
    } else {
        Node* newNode = createNode(curr->count + 1);
        insertAfter(curr, newNode);
        addKeyToNode(newNode, key);
    }

    if (obj->maxCount == curr->count && curr->size == 0) {
        obj->maxCount = nextNode->count;
    }
}

char* allOneGetMaxKey(AllOne* obj) {
    if (obj->size == 0) return "";
    return obj->tail->prev->keys[0];
}

char* allOneGetMinKey(AllOne* obj) {
    if (obj->size == 0) return "";
    return obj->head->next->keys[0];
}

void allOneFree(AllOne* obj) {
    Node* curr = obj->head;
    while (curr) {
        Node* next = curr->next;
        free(curr->keys);
        free(curr);
        curr = next;
    }
    free(obj);
}