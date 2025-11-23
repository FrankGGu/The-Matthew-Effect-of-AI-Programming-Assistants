#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int val;
    struct Node *prev;
    struct Node *next;
} Node;

typedef struct {
    Node *head;
    Node *tail;
    int size;
} FrontMiddleBackQueue;

FrontMiddleBackQueue* frontMiddleBackQueueCreate() {
    FrontMiddleBackQueue *queue = (FrontMiddleBackQueue*)malloc(sizeof(FrontMiddleBackQueue));
    queue->head = NULL;
    queue->tail = NULL;
    queue->size = 0;
    return queue;
}

void pushFront(FrontMiddleBackQueue* obj, int val) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->prev = NULL;
    newNode->next = obj->head;

    if (obj->head == NULL) {
        obj->head = newNode;
        obj->tail = newNode;
    } else {
        obj->head->prev = newNode;
        obj->head = newNode;
    }
    obj->size++;
}

void pushMiddle(FrontMiddleBackQueue* obj, int val) {
    if (obj->size == 0) {
        pushFront(obj, val);
        return;
    }

    int middleIndex = (obj->size + 1) / 2;
    Node *curr = obj->head;
    for (int i = 1; i < middleIndex; i++) {
        curr = curr->next;
    }

    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = curr;
    newNode->prev = curr->prev;

    if (curr->prev != NULL) {
        curr->prev->next = newNode;
    } else {
        obj->head = newNode;
    }
    curr->prev = newNode;
    obj->size++;
}

void pushBack(FrontMiddleBackQueue* obj, int val) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = NULL;
    newNode->prev = obj->tail;

    if (obj->tail == NULL) {
        obj->head = newNode;
        obj->tail = newNode;
    } else {
        obj->tail->next = newNode;
        obj->tail = newNode;
    }
    obj->size++;
}

int popFront(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }

    Node *temp = obj->head;
    int val = temp->val;

    if (obj->size == 1) {
        obj->head = NULL;
        obj->tail = NULL;
    } else {
        obj->head = obj->head->next;
        obj->head->prev = NULL;
    }

    free(temp);
    obj->size--;
    return val;
}

int popMiddle(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }

    int middleIndex = obj->size / 2;
    Node *curr = obj->head;
    for (int i = 0; i < middleIndex; i++) {
        curr = curr->next;
    }

    int val = curr->val;

    if (obj->size == 1) {
        obj->head = NULL;
        obj->tail = NULL;
    } else {
        if (curr->prev != NULL) {
            curr->prev->next = curr->next;
        } else {
            obj->head = curr->next;
        }

        if (curr->next != NULL) {
            curr->next->prev = curr->prev;
        } else {
            obj->tail = curr->prev;
        }
    }

    free(curr);
    obj->size--;
    return val;
}

int popBack(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }

    Node *temp = obj->tail;
    int val = temp->val;

    if (obj->size == 1) {
        obj->head = NULL;
        obj->tail = NULL;
    } else {
        obj->tail = obj->tail->prev;
        obj->tail->next = NULL;
    }

    free(temp);
    obj->size--;
    return val;
}

void frontMiddleBackQueueFree(FrontMiddleBackQueue* obj) {
    while (obj->head != NULL) {
        Node *temp = obj->head;
        obj->head = obj->head->next;
        free(temp);
    }
    free(obj);
}