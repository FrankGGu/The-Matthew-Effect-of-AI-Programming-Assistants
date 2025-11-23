#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct Node {
    int count;
    char* key;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct {
    Node* head;
    Node* tail;
    struct {
        Node** table;
        int size;
        int capacity;
    } keyMap;
} AllOne;

AllOne* allOneCreate() {
    AllOne* obj = (AllOne*)malloc(sizeof(AllOne));
    obj->head = NULL;
    obj->tail = NULL;

    obj->keyMap.capacity = 10000;
    obj->keyMap.size = 0;
    obj->keyMap.table = (Node**)calloc(obj->keyMap.capacity, sizeof(Node*));

    return obj;
}

unsigned int hash(AllOne* obj, char* key) {
    unsigned int hash = 5381;
    int c;
    while ((c = *key++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash % obj->keyMap.capacity;
}

void insertNode(AllOne* obj, Node* node) {
    if (!obj->head) {
        obj->head = node;
        obj->tail = node;
        node->prev = NULL;
        node->next = NULL;
        return;
    }

    Node* curr = obj->head;
    Node* prev = NULL;

    while (curr && curr->count > node->count) {
        prev = curr;
        curr = curr->next;
    }

    if (!prev) {
        node->next = obj->head;
        node->prev = NULL;
        obj->head->prev = node;
        obj->head = node;
    } else if (!curr) {
        node->prev = obj->tail;
        node->next = NULL;
        obj->tail->next = node;
        obj->tail = node;
    } else {
        node->prev = prev;
        node->next = curr;
        prev->next = node;
        curr->prev = node;
    }
}

void removeNode(AllOne* obj, Node* node) {
    if (node->prev) {
        node->prev->next = node->next;
    } else {
        obj->head = node->next;
    }

    if (node->next) {
        node->next->prev = node->prev;
    } else {
        obj->tail = node->prev;
    }
}

void allOneInc(AllOne* obj, char* key) {
    unsigned int idx = hash(obj, key);
    Node* node = obj->keyMap.table[idx];

    while (node && strcmp(node->key, key) != 0) {
        idx = (idx + 1) % obj->keyMap.capacity;
        node = obj->keyMap.table[idx];
    }

    if (node) {
        removeNode(obj, node);
        node->count++;
        insertNode(obj, node);
    } else {
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->key = strdup(key);
        newNode->count = 1;

        while (obj->keyMap.table[idx] != NULL) {
            idx = (idx + 1) % obj->keyMap.capacity;
        }
        obj->keyMap.table[idx] = newNode;
        obj->keyMap.size++;

        insertNode(obj, newNode);
    }
}

void allOneDec(AllOne* obj, char* key) {
    unsigned int idx = hash(obj, key);
    Node* node = obj->keyMap.table[idx];

    while (node && strcmp(node->key, key) != 0) {
        idx = (idx + 1) % obj->keyMap.capacity;
        node = obj->keyMap.table[idx];
    }

    if (!node) return;

    removeNode(obj, node);
    node->count--;

    if (node->count == 0) {
        free(node->key);
        obj->keyMap.table[idx] = NULL;
        obj->keyMap.size--;
        free(node);
    } else {
        insertNode(obj, node);
    }
}

char* allOneGetMaxKey(AllOne* obj) {
    if (!obj->head) return "";
    return obj->head->key;
}

char* allOneGetMinKey(AllOne* obj) {
    if (!obj->tail) return "";
    return obj->tail->key;
}

void allOneFree(AllOne* obj) {
    for (int i = 0; i < obj->keyMap.capacity; i++) {
        if (obj->keyMap.table[i]) {
            free(obj->keyMap.table[i]->key);
            free(obj->keyMap.table[i]);
        }
    }
    free(obj->keyMap.table);

    Node* curr = obj->head;
    while (curr) {
        Node* temp = curr;
        curr = curr->next;
        free(temp);
    }

    free(obj);
}

/**
 * Your AllOne struct will be instantiated and called as such:
 * AllOne* obj = allOneCreate();
 * allOneInc(obj, key);
 * allOneDec(obj, key);
 * char* param_3 = allOneGetMaxKey(obj);
 * char* param_4 = allOneGetMinKey(obj);
 * allOneFree(obj);
 */