#include <stdlib.h>
#include <stdbool.h>

typedef struct Node {
    int left, right;
    struct Node* next;
} Node;

typedef struct {
    Node* head;
} RangeModule;

RangeModule* rangeModuleCreate() {
    RangeModule* obj = (RangeModule*)malloc(sizeof(RangeModule));
    obj->head = (Node*)malloc(sizeof(Node));
    obj->head->next = NULL;
    return obj;
}

void rangeModuleAddRange(RangeModule* obj, int left, int right) {
    Node* prev = obj->head;
    Node* curr = obj->head->next;

    while (curr != NULL && curr->right < left) {
        prev = curr;
        curr = curr->next;
    }

    if (curr == NULL) {
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->left = left;
        newNode->right = right;
        newNode->next = NULL;
        prev->next = newNode;
        return;
    }

    if (curr->left > right) {
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->left = left;
        newNode->right = right;
        newNode->next = curr;
        prev->next = newNode;
        return;
    }

    int newLeft = (left < curr->left) ? left : curr->left;
    int newRight = (right > curr->right) ? right : curr->right;

    Node* start = prev;
    prev = curr;
    curr = curr->next;

    while (curr != NULL && curr->left <= newRight) {
        newRight = (curr->right > newRight) ? curr->right : newRight;
        prev = curr;
        curr = curr->next;
        free(prev);
    }

    start->next->left = newLeft;
    start->next->right = newRight;
    start->next->next = curr;
}

bool rangeModuleQueryRange(RangeModule* obj, int left, int right) {
    Node* curr = obj->head->next;

    while (curr != NULL && curr->right < left) {
        curr = curr->next;
    }

    if (curr == NULL || curr->left > left) {
        return false;
    }

    return right <= curr->right;
}

void rangeModuleRemoveRange(RangeModule* obj, int left, int right) {
    Node* prev = obj->head;
    Node* curr = obj->head->next;

    while (curr != NULL && curr->right <= left) {
        prev = curr;
        curr = curr->next;
    }

    if (curr == NULL) {
        return;
    }

    if (curr->left < left) {
        if (curr->right > right) {
            Node* newNode = (Node*)malloc(sizeof(Node));
            newNode->left = right;
            newNode->right = curr->right;
            newNode->next = curr->next;
            curr->right = left;
            curr->next = newNode;
            return;
        } else {
            curr->right = left;
            prev = curr;
            curr = curr->next;
        }
    }

    while (curr != NULL && curr->right <= right) {
        prev->next = curr->next;
        free(curr);
        curr = prev->next;
    }

    if (curr != NULL && curr->left < right) {
        curr->left = right;
    }
}

void rangeModuleFree(RangeModule* obj) {
    Node* curr = obj->head;
    while (curr != NULL) {
        Node* temp = curr;
        curr = curr->next;
        free(temp);
    }
    free(obj);
}