typedef struct Node {
    int val;
    struct Node* next;
    struct Node* prev;
} Node;

typedef struct {
    Node* front;
    Node* back;
    Node* middle;
    int size;
} FrontMiddleBackQueue;

FrontMiddleBackQueue* frontMiddleBackQueueCreate() {
    FrontMiddleBackQueue* obj = (FrontMiddleBackQueue*)malloc(sizeof(FrontMiddleBackQueue));
    obj->front = NULL;
    obj->back = NULL;
    obj->middle = NULL;
    obj->size = 0;
    return obj;
}

void frontMiddleBackQueuePushFront(FrontMiddleBackQueue* obj, int val) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = obj->front;
    newNode->prev = NULL;

    if (obj->size == 0) {
        obj->front = newNode;
        obj->back = newNode;
        obj->middle = newNode;
    } else {
        if (obj->front) {
            obj->front->prev = newNode;
        }
        obj->front = newNode;
    }

    obj->size++;

    if (obj->size == 1) {
        obj->middle = obj->front;
    } else if (obj->size % 2 == 0) {
        obj->middle = obj->middle->prev;
    }
}

void frontMiddleBackQueuePushMiddle(FrontMiddleBackQueue* obj, int val) {
    if (obj->size == 0) {
        frontMiddleBackQueuePushFront(obj, val);
        return;
    }

    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;

    if (obj->size % 2 == 0) {
        newNode->next = obj->middle->next;
        newNode->prev = obj->middle;
        if (obj->middle->next) {
            obj->middle->next->prev = newNode;
        }
        obj->middle->next = newNode;

        if (obj->middle == obj->back) {
            obj->back = newNode;
        }
    } else {
        newNode->next = obj->middle;
        newNode->prev = obj->middle->prev;
        if (obj->middle->prev) {
            obj->middle->prev->next = newNode;
        } else {
            obj->front = newNode;
        }
        obj->middle->prev = newNode;
    }

    obj->size++;
    obj->middle = newNode;
}

void frontMiddleBackQueuePushBack(FrontMiddleBackQueue* obj, int val) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = NULL;
    newNode->prev = obj->back;

    if (obj->size == 0) {
        obj->front = newNode;
        obj->back = newNode;
        obj->middle = newNode;
    } else {
        if (obj->back) {
            obj->back->next = newNode;
        }
        obj->back = newNode;
    }

    obj->size++;

    if (obj->size == 1) {
        obj->middle = obj->back;
    } else if (obj->size % 2 == 1) {
        obj->middle = obj->middle->next;
    }
}

int frontMiddleBackQueuePopFront(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }

    Node* temp = obj->front;
    int val = temp->val;

    if (obj->size == 1) {
        obj->front = NULL;
        obj->back = NULL;
        obj->middle = NULL;
    } else {
        obj->front = obj->front->next;
        if (obj->front) {
            obj->front->prev = NULL;
        }

        if (obj->size % 2 == 0) {
            obj->middle = obj->middle->next;
        }
    }

    free(temp);
    obj->size--;
    return val;
}

int frontMiddleBackQueuePopMiddle(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }

    Node* temp = obj->middle;
    int val = temp->val;

    if (obj->size == 1) {
        obj->front = NULL;
        obj->back = NULL;
        obj->middle = NULL;
    } else {
        if (temp->prev) {
            temp->prev->next = temp->next;
        } else {
            obj->front = temp->next;
        }

        if (temp->next) {
            temp->next->prev = temp->prev;
        } else {
            obj->back = temp->prev;
        }

        if (obj->size % 2 == 0) {
            obj->middle = temp->next;
        } else {
            obj->middle = temp->prev;
        }
    }

    free(temp);
    obj->size--;
    return val;
}

int frontMiddleBackQueuePopBack(FrontMiddleBackQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }

    Node* temp = obj->back;
    int val = temp->val;

    if (obj->size == 1) {
        obj->front = NULL;
        obj->back = NULL;
        obj->middle = NULL;
    } else {
        obj->back = obj->back->prev;
        if (obj->back) {
            obj->back->next = NULL;
        }

        if (obj->size % 2 == 1) {
            obj->middle = obj->middle->prev;
        }
    }

    free(temp);
    obj->size--;
    return val;
}

void frontMiddleBackQueueFree(FrontMiddleBackQueue* obj) {
    while (obj->front) {
        Node* temp = obj->front;
        obj->front = obj->front->next;
        free(temp);
    }
    free(obj);
}

/**
 * Your FrontMiddleBackQueue struct will be instantiated and called as such:
 * FrontMiddleBackQueue* obj = frontMiddleBackQueueCreate();
 * frontMiddleBackQueuePushFront(obj, val);

 * frontMiddleBackQueuePushMiddle(obj, val);

 * frontMiddleBackQueuePushBack(obj, val);

 * int param_4 = frontMiddleBackQueuePopFront(obj);

 * int param_5 = frontMiddleBackQueuePopMiddle(obj);

 * int param_6 = frontMiddleBackQueuePopBack(obj);

 * frontMiddleBackQueueFree(obj);
*/