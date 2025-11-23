#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *name;
    int age;
} Animal;

typedef struct Node {
    Animal *animal;
    struct Node *next;
} Node;

typedef struct {
    Node *head;
} LinkedList;

LinkedList* createLinkedList() {
    LinkedList *list = (LinkedList*)malloc(sizeof(LinkedList));
    list->head = NULL;
    return list;
}

void addAnimal(LinkedList *list, char *name, int age) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->animal = (Animal*)malloc(sizeof(Animal));
    newNode->animal->name = strdup(name);
    newNode->animal->age = age;
    newNode->next = list->head;
    list->head = newNode;
}

int getAge(LinkedList *list, char *name) {
    Node *current = list->head;
    while (current != NULL) {
        if (strcmp(current->animal->name, name) == 0) {
            return current->animal->age;
        }
        current = current->next;
    }
    return -1;
}

void freeLinkedList(LinkedList *list) {
    Node *current = list->head;
    while (current != NULL) {
        Node *next = current->next;
        free(current->animal->name);
        free(current->animal);
        free(current);
        current = next;
    }
    free(list);
}