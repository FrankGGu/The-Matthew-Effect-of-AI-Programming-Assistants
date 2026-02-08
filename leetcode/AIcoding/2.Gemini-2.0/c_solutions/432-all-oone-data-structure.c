#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int count;
    char* str;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct {
    Node* head;
    Node* tail;
    int size;
} DoublyLinkedList;

typedef struct {
    DoublyLinkedList* list;
    Node** map;
    int capacity;
} AllOne;

DoublyLinkedList* doublyLinkedListCreate() {
    DoublyLinkedList* list = (DoublyLinkedList*)malloc(sizeof(DoublyLinkedList));
    list->head = (Node*)malloc(sizeof(Node));
    list->tail = (Node*)malloc(sizeof(Node));
    list->head->next = list->tail;
    list->tail->prev = list->head;
    list->head->prev = NULL;
    list->tail->next = NULL;
    list->size = 0;
    return list;
}

void doublyLinkedListAddBefore(DoublyLinkedList* list, Node* node, char* str, int count) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->str = strdup(str);
    newNode->count = count;

    newNode->next = node;
    newNode->prev = node->prev;
    node->prev->next = newNode;
    node->prev = newNode;

    list->size++;
}

void doublyLinkedListRemove(DoublyLinkedList* list, Node* node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
    free(node->str);
    free(node);
    list->size--;
}

void doublyLinkedListFree(DoublyLinkedList* list) {
    Node* curr = list->head;
    while (curr != NULL) {
        Node* temp = curr;
        curr = curr->next;
        free(temp);
    }
    free(list);
}

AllOne* allOneCreate() {
    AllOne* obj = (AllOne*)malloc(sizeof(AllOne));
    obj->list = doublyLinkedListCreate();
    obj->capacity = 100000;
    obj->map = (Node**)malloc(obj->capacity * sizeof(Node*));
    for (int i = 0; i < obj->capacity; i++) {
        obj->map[i] = NULL;
    }
    return obj;
}

void allOneInc(AllOne* obj, char* key) {
    int hash = 0;
    for (int i = 0; key[i] != '\0'; i++) {
        hash = (hash * 31 + key[i]) % obj->capacity;
    }

    if (obj->map[hash] == NULL) {
        doublyLinkedListAddBefore(obj->list, obj->list->tail, key, 1);
        obj->map[hash] = obj->list->tail->prev;
    } else {
        Node* node = obj->map[hash];
        node->count++;

        Node* curr = node->next;
        while (curr != obj->list->tail && curr->count <= node->count) {
            curr = curr->next;
        }

        if (curr->prev->count != node->count) {
            doublyLinkedListAddBefore(obj->list, curr, key, node->count);
            Node* newNode = curr->prev;
            obj->map[hash] = newNode;
            doublyLinkedListRemove(obj->list, node);
        } else {
            free(node->str);
            node->str = strdup(key);
            obj->map[hash] = node;
        }
    }
}

void allOneDec(AllOne* obj, char* key) {
    int hash = 0;
    for (int i = 0; key[i] != '\0'; i++) {
        hash = (hash * 31 + key[i]) % obj->capacity;
    }

    Node* node = obj->map[hash];
    if (node == NULL) {
        return;
    }

    node->count--;

    if (node->count == 0) {
        doublyLinkedListRemove(obj->list, node);
        free(node->str);
        obj->map[hash] = NULL;
        return;
    }

    Node* curr = node->prev;
    while (curr != obj->list->head && curr->count >= node->count) {
        curr = curr->prev;
    }

    if (curr->next->count != node->count) {
        doublyLinkedListAddBefore(obj->list, node, key, node->count);
        Node* newNode = node->prev->next;
        obj->map[hash] = newNode;
        doublyLinkedListRemove(obj->list, node);
    } else {
        free(node->str);
        node->str = strdup(key);
        obj->map[hash] = node;
    }

}

char* allOneGetMaxKey(AllOne* obj) {
    if (obj->list->head->next == obj->list->tail) {
        return "";
    }
    return obj->list->tail->prev->str;
}

char* allOneGetMinKey(AllOne* obj) {
    if (obj->list->head->next == obj->list->tail) {
        return "";
    }
    return obj->list->head->next->str;
}

void allOneFree(AllOne* obj) {
    doublyLinkedListFree(obj->list);
    free(obj->map);
    free(obj);
}