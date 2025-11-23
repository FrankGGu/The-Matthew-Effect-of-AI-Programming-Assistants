#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct {
    Node* front;
    Node* back;
    int size;
} FrontMiddleBackQueue;

FrontMiddleBackQueue* frontMiddleBackQueueCreate() {
    FrontMiddleBackQueue* obj = (FrontMiddleBackQueue*)malloc(sizeof(FrontMiddleBackQueue));
    obj->front = NULL;
    obj->back = NULL;
    obj->size = 0;
    return obj;
}

void frontMiddleBackQueuePushFront(FrontMiddleBackQueue* obj, int val) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = val;
    node->prev = NULL;
    node->next = obj->front;
    if (obj->front) {
        obj->front->prev = node;
    } else {
        obj->back = node;
    }
    obj->front = node;
    obj->size++;
}

void frontMiddleBackQueuePushMiddle(FrontMiddleBackQueue* obj, int val) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = val;
    if (obj->size == 0) {
        obj->front = node;
        obj->back = node;
        node->prev = NULL;
        node->next = NULL;
        obj->size++;
        return;
    }
    Node* curr = obj->front;
    int i;
    for (i = 0; i < (obj->size / 2); i++) {
        curr = curr->next;
    }
    node->prev = curr->prev;
    node->next = curr;
    if (curr->prev) {
        curr->prev->next = node;
    } else {
        obj->front = node;
    }
    curr->prev = node;
    obj->size++;
}

void frontMiddleBackQueuePushBack(FrontMiddleBackQueue* obj, int val) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = val;
    node->next = NULL;
    node->prev = obj->back;
    if (obj->back) {
        obj->back->next = node;
    } else {
        obj->front = node;
    }
    obj->back = node;
    obj->size++;
}

int frontMiddleBackQueuePopFront(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }
    Node* node = obj->front;
    int val = node->val;
    if (obj->front == obj->back) {
        obj->front = NULL;
        obj->back = NULL;
    } else {
        obj->front = node->next;
        obj->front->prev = NULL;
    }
    free(node);
    obj->size--;
    return val;
}

int frontMiddleBackQueuePopMiddle(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }
    Node* curr = obj->front;
    int i;
    for (i = 0; i < (obj->size / 2); i++) {
        curr = curr->next;
    }
    int val = curr->val;
    if (curr->prev) {
        curr->prev->next = curr->next;
    } else {
        obj->front = curr->next;
    }
    if (curr->next) {
        curr->next->prev = curr->prev;
    } else {
        obj->back = curr->prev;
    }
    free(curr);
    obj->size--;
    return val;
}

int frontMiddleBackQueuePopBack(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }
    Node* node = obj->back;
    int val = node->val;
    if (obj->front == obj->back) {
        obj->front = NULL;
        obj->back = NULL;
    } else {
        obj->back = node->prev;
        obj->back->next = NULL;
    }
    free(node);
    obj->size--;
    return val;
}

void frontMiddleBackQueueFree(FrontMiddleBackQueue* obj) {
    Node* curr = obj->front;
    while (curr) {
        Node* next = curr->next;
        free(curr);
        curr = next;
    }
    free(obj);
}