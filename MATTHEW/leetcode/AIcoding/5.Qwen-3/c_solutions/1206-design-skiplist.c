#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct Node {
    int val;
    struct Node** next;
} Node;

typedef struct {
    Node* head;
    int level;
} Skiplist;

Node* createNode(int val, int level) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = val;
    node->next = (Node**)malloc((level + 1) * sizeof(Node*));
    for (int i = 0; i <= level; i++) {
        node->next[i] = NULL;
    }
    return node;
}

Skiplist* skiplistCreate() {
    Skiplist* obj = (Skiplist*)malloc(sizeof(Skiplist));
    obj->head = createNode(0, 0);
    obj->level = 0;
    return obj;
}

void skiplistInsert(Skiplist* obj, int value) {
    Node* current = obj->head;
    Node* update[obj->level + 1];
    for (int i = obj->level; i >= 0; i--) {
        while (current->next[i] && current->next[i]->val < value) {
            current = current->next[i];
        }
        update[i] = current;
    }

    int newLevel = 0;
    while (rand() % 2 == 1 && newLevel < obj->level + 1) {
        newLevel++;
    }

    if (newLevel > obj->level) {
        for (int i = obj->level + 1; i < newLevel + 1; i++) {
            update[i] = obj->head;
        }
        obj->level = newLevel;
    }

    Node* newNode = createNode(value, newLevel);
    for (int i = 0; i <= newLevel; i++) {
        newNode->next[i] = update[i]->next[i];
        update[i]->next[i] = newNode;
    }
}

bool skiplistSearch(Skiplist* obj, int target) {
    Node* current = obj->head;
    for (int i = obj->level; i >= 0; i--) {
        while (current->next[i] && current->next[i]->val < target) {
            current = current->next[i];
        }
    }
    return current->next[0] && current->next[0]->val == target;
}

bool skiplistErase(Skiplist* obj, int value) {
    Node* current = obj->head;
    bool found = false;
    for (int i = obj->level; i >= 0; i--) {
        while (current->next[i] && current->next[i]->val < value) {
            current = current->next[i];
        }
        if (current->next[i] && current->next[i]->val == value) {
            found = true;
            current->next[i] = current->next[i]->next[i];
        }
    }
    return found;
}

void skiplistFree(Skiplist* obj) {
    Node* current = obj->head;
    Node* next;
    while (current) {
        next = current->next[0];
        free(current->next);
        free(current);
        current = next;
    }
    free(obj);
}