#include <stdlib.h> // For malloc, free

typedef struct Node {
    int val;
    struct Node *prev;
    struct Node *next;
} Node;

typedef struct {
    Node *left_head;
    Node *left_tail;
    int left_size;

    Node *right_head;
    Node *right_tail;
    int right_size;
} FrontMiddleBackQueue;

Node* create_node(int val) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->prev = NULL;
    newNode->next = NULL;
    return newNode;
}

void balance(FrontMiddleBackQueue *obj) {
    // If left_size is too large, move from left tail to right head
    while (obj->left_size > obj->right_size + 1) {
        Node *node_to_move = obj->left_tail;

        // Remove from left
        obj->left_tail = node_to_move->prev;
        if (obj->left_tail) {
            obj->left_tail->next = NULL;
        } else {
            obj->left_head = NULL;
        }
        obj->left_size--;

        // Add to right front
        node_to_move->prev = NULL;
        node_to_move->next = obj->right_head;
        if (obj->right_head) {
            obj->right_head->prev = node_to_move;
        } else {
            obj->right_tail = node_to_move;
        }
        obj->right_head = node_to_move;
        obj->right_size++;
    }

    // If left_size is too small, move from right head to left tail
    while (obj->left_size < obj->right_size) {
        Node *node_to_move = obj->right_head;

        // Remove from right
        obj->right_head = node_to_move->next;
        if (obj->right_head) {
            obj->right_head->prev = NULL;
        } else {
            obj->right_tail = NULL;
        }
        obj->right_size--;

        // Add to left back
        node_to_move->next = NULL;
        node_to_move->prev = obj->left_tail;
        if (obj->left_tail) {
            obj->left_tail->next = node_to_move;
        } else {
            obj->left_head = node_to_move;
        }
        obj->left_tail = node_to_move;
        obj->left_size++;
    }
}

FrontMiddleBackQueue* frontMiddleBackQueueCreate() {
    FrontMiddleBackQueue* obj = (FrontMiddleBackQueue*)malloc(sizeof(FrontMiddleBackQueue));
    obj->left_head = NULL;
    obj->left_tail = NULL;
    obj->left_size = 0;
    obj->right_head = NULL;
    obj->right_tail = NULL;
    obj->right_size = 0;
    return obj;
}

void frontMiddleBackQueuePushFront(FrontMiddleBackQueue* obj, int val) {
    Node* newNode = create_node(val);
    if (obj->left_head == NULL) { 
        obj->left_head = newNode;
        obj->left_tail = newNode;
    } else {
        newNode->next = obj->left_head;
        obj->left_head->prev = newNode;
        obj->left_head = newNode;
    }
    obj->left_size++;
    balance(obj);
}

void frontMiddleBackQueuePushMiddle(FrontMiddleBackQueue* obj, int val) {
    Node* newNode = create_node(val);
    // Push to the end of the left list (which is the middle position)
    if (obj->left_head == NULL) { 
        obj->left_head = newNode;
        obj->left_tail = newNode;
    } else {
        newNode->prev = obj->left_tail;
        obj->left_tail->next = newNode;
        obj->left_tail = newNode;
    }
    obj->left_size++;
    balance(obj);
}

void frontMiddleBackQueuePushBack(FrontMiddleBackQueue* obj, int val) {
    Node* newNode = create_node(val);
    if (obj->right_head == NULL) { 
        obj->right_head = newNode;
        obj->right_tail = newNode;
    } else {
        newNode->prev = obj->right_tail;
        obj->right_tail->next = newNode;
        obj->right_tail = newNode;
    }
    obj->right_size++;
    balance(obj);
}

int frontMiddleBackQueuePopFront(FrontMiddleBackQueue* obj) {
    if (obj->left_size == 0 && obj->right_size == 0) {
        return -1; // Queue is empty
    }

    int val;
    Node *node_to_free;

    if (obj->left_size > 0) {
        node_to_free = obj->left_head;
        val = node_to_free->val;

        obj->left_head = node_to_free->next;
        if (obj->left_head) {
            obj->left_head->prev = NULL;
        } else {
            obj->left_tail = NULL;
        }
        obj->left_size--;
    } else { // left list is empty, but right list must contain the only element
        node_to_free = obj->right_head;
        val = node_to_free->val;

        obj->right_head = node_to_free->next;
        if (obj->right_head) {
            obj->right_head->prev = NULL;
        } else {
            obj->right_tail = NULL;
        }
        obj->right_size--;
    }
    free(node_to_free);
    balance(obj);
    return val;
}

int frontMiddleBackQueuePopMiddle(FrontMiddleBackQueue* obj) {
    if (obj->left_size == 0 && obj->right_size == 0) {
        return -1; // Queue is empty
    }

    // The middle element is always the tail of the left list
    // due to the balancing invariant (left_size == right_size or left_size == right_size + 1)
    Node *node_to_free = obj->left_tail;
    int val = node_to_free->val;

    // Remove from left
    obj->left_tail = node_to_free->prev;
    if (obj->left_tail) {
        obj->left_tail->next = NULL;
    } else {
        obj->left_head = NULL;
    }
    obj->left_size--;

    free(node_to_free);
    balance(obj);
    return val;
}

int frontMiddleBackQueuePopBack(FrontMiddleBackQueue* obj) {
    if (obj->left_size == 0 && obj->right_size == 0) {
        return -1; // Queue is empty
    }

    int val;
    Node *node_to_free;

    if (obj->right_size > 0) {
        node_to_free = obj->right_tail;
        val = node_to_free->val;

        obj->right_tail = node_to_free->prev;
        if (obj->right_tail) {
            obj->right_tail->next = NULL;
        } else {
            obj->right_head = NULL;
        }
        obj->right_size--;
    } else { // right list is empty, but left list must contain the only element
        node_to_free = obj->left_tail;
        val = node_to_free->val;

        obj->left_tail = node_to_free->prev;
        if (obj->left_tail) {
            obj->left_tail->next = NULL;
        } else {
            obj->left_head = NULL;
        }
        obj->left_size--;
    }
    free(node_to_free);
    balance(obj);
    return val;
}

void frontMiddleBackQueueFree(FrontMiddleBackQueue* obj) {
    Node *current = obj->left_head;
    while (current) {
        Node *next = current->next;
        free(current);
        current = next;
    }
    current = obj->right_head;
    while (current) {
        Node *next = current->next;
        free(current);
        current = next;
    }
    free(obj);
}