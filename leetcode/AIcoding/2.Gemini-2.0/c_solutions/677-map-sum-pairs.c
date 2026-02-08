#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char* key;
    int val;
    struct Node* next;
} Node;

typedef struct {
    Node** table;
    int capacity;
    int size;
} MapSum;

int hash(char* key, int capacity) {
    unsigned long hash = 5381;
    int c;

    while ((c = *key++))
        hash = ((hash << 5) + hash) + c; 

    return hash % capacity;
}

MapSum* mapSumCreate() {
    MapSum* obj = (MapSum*)malloc(sizeof(MapSum));
    obj->capacity = 10000;
    obj->table = (Node**)calloc(obj->capacity, sizeof(Node*));
    obj->size = 0;
    return obj;
}

void mapSumInsert(MapSum* obj, char *key, int val) {
    int index = hash(key, obj->capacity);
    Node* current = obj->table[index];
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            current->val = val;
            return;
        }
        current = current->next;
    }

    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = (char*)malloc(strlen(key) + 1);
    strcpy(newNode->key, key);
    newNode->val = val;
    newNode->next = obj->table[index];
    obj->table[index] = newNode;
    obj->size++;
}

int mapSumSum(MapSum* obj, char *prefix) {
    int sum = 0;
    for (int i = 0; i < obj->capacity; i++) {
        Node* current = obj->table[i];
        while (current != NULL) {
            if (strncmp(current->key, prefix, strlen(prefix)) == 0) {
                sum += current->val;
            }
            current = current->next;
        }
    }
    return sum;
}

void mapSumFree(MapSum* obj) {
    for (int i = 0; i < obj->capacity; i++) {
        Node* current = obj->table[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp->key);
            free(temp);
        }
    }
    free(obj->table);
    free(obj);
}