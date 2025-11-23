#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int importance;
    int* subordinates;
    int subordinatesSize;
} Employee;

typedef struct {
    int key;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size;
} HashTable;

HashTable* createHashTable(int size) {
    HashTable* table = (HashTable*)malloc(sizeof(HashTable));
    table->size = size;
    table->buckets = (Node**)malloc(size * sizeof(Node*));
    for (int i = 0; i < size; ++i) {
        table->buckets[i] = NULL;
    }
    return table;
}

void insert(HashTable* table, int key) {
    int index = key % table->size;
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->next = table->buckets[index];
    table->buckets[index] = newNode;
}

int contains(HashTable* table, int key) {
    int index = key % table->size;
    Node* current = table->buckets[index];
    while (current) {
        if (current->key == key) {
            return 1;
        }
        current = current->next;
    }
    return 0;
}

void freeHashTable(HashTable* table) {
    for (int i = 0; i < table->size; ++i) {
        Node* current = table->buckets[i];
        while (current) {
            Node* next = current->next;
            free(current);
            current = next;
        }
    }
    free(table->buckets);
    free(table);
}

int getImportance(Employee** employees, int employeesSize, int id) {
    HashTable* table = createHashTable(1000);
    for (int i = 0; i < employeesSize; ++i) {
        insert(table, employees[i]->id);
    }

    int totalImportance = 0;
    int queue[1000];
    int front = 0, rear = 0;
    queue[rear++] = id;

    while (front < rear) {
        int currentId = queue[front++];
        for (int i = 0; i < employeesSize; ++i) {
            if (employees[i]->id == currentId) {
                totalImportance += employees[i]->importance;
                for (int j = 0; j < employees[i]->subordinatesSize; ++j) {
                    queue[rear++] = employees[i]->subordinates[j];
                }
                break;
            }
        }
    }

    freeHashTable(table);
    return totalImportance;
}