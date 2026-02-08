#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    struct Node* next;
} Node;

typedef struct {
    Node* head;
    int size;
} MyLinkedList;

MyLinkedList* myLinkedListCreate() {
    MyLinkedList* list = (MyLinkedList*)malloc(sizeof(MyLinkedList));
    list->head = NULL;
    list->size = 0;
    return list;
}

int myLinkedListGet(MyLinkedList* obj, int index) {
    if (index < 0 || index >= obj->size) return -1;
    Node* current = obj->head;
    for (int i = 0; i < index; i++) {
        current = current->next;
    }
    return current->val;
}

void myLinkedListAddAtHead(MyLinkedList* obj, int val) {
    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->val = val;
    new_node->next = obj->head;
    obj->head = new_node;
    obj->size++;
}

void myLinkedListAddAtTail(MyLinkedList* obj, int val) {
    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->val = val;
    new_node->next = NULL;
    if (obj->head == NULL) {
        obj->head = new_node;
    } else {
        Node* current = obj->head;
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = new_node;
    }
    obj->size++;
}

void myLinkedListAddAtIndex(MyLinkedList* obj, int index, int val) {
    if (index < 0 || index > obj->size) return;
    if (index == 0) {
        myLinkedListAddAtHead(obj, val);
        return;
    }
    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->val = val;
    Node* current = obj->head;
    for (int i = 0; i < index - 1; i++) {
        current = current->next;
    }
    new_node->next = current->next;
    current->next = new_node;
    obj->size++;
}

void myLinkedListDeleteAtIndex(MyLinkedList* obj, int index) {
    if (index < 0 || index >= obj->size) return;
    if (index == 0) {
        Node* temp = obj->head;
        obj->head = obj->head->next;
        free(temp);
        obj->size--;
        return;
    }
    Node* current = obj->head;
    for (int i = 0; i < index - 1; i++) {
        current = current->next;
    }
    Node* temp = current->next;
    current->next = current->next->next;
    free(temp);
    obj->size--;
}

void myLinkedListFree(MyLinkedList* obj) {
    Node* current = obj->head;
    while (current != NULL) {
        Node* next = current->next;
        free(current);
        current = next;
    }
    free(obj);
}