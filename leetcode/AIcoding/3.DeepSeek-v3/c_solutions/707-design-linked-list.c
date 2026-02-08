typedef struct MyLinkedListNode {
    int val;
    struct MyLinkedListNode* next;
} MyLinkedListNode;

typedef struct {
    MyLinkedListNode* head;
    int size;
} MyLinkedList;

MyLinkedList* myLinkedListCreate() {
    MyLinkedList* obj = (MyLinkedList*)malloc(sizeof(MyLinkedList));
    obj->head = NULL;
    obj->size = 0;
    return obj;
}

int myLinkedListGet(MyLinkedList* obj, int index) {
    if (index < 0 || index >= obj->size) return -1;

    MyLinkedListNode* current = obj->head;
    for (int i = 0; i < index; i++) {
        current = current->next;
    }
    return current->val;
}

void myLinkedListAddAtHead(MyLinkedList* obj, int val) {
    MyLinkedListNode* newNode = (MyLinkedListNode*)malloc(sizeof(MyLinkedListNode));
    newNode->val = val;
    newNode->next = obj->head;
    obj->head = newNode;
    obj->size++;
}

void myLinkedListAddAtTail(MyLinkedList* obj, int val) {
    MyLinkedListNode* newNode = (MyLinkedListNode*)malloc(sizeof(MyLinkedListNode));
    newNode->val = val;
    newNode->next = NULL;

    if (obj->head == NULL) {
        obj->head = newNode;
    } else {
        MyLinkedListNode* current = obj->head;
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = newNode;
    }
    obj->size++;
}

void myLinkedListAddAtIndex(MyLinkedList* obj, int index, int val) {
    if (index < 0 || index > obj->size) return;

    if (index == 0) {
        myLinkedListAddAtHead(obj, val);
        return;
    }

    MyLinkedListNode* newNode = (MyLinkedListNode*)malloc(sizeof(MyLinkedListNode));
    newNode->val = val;

    MyLinkedListNode* current = obj->head;
    for (int i = 0; i < index - 1; i++) {
        current = current->next;
    }

    newNode->next = current->next;
    current->next = newNode;
    obj->size++;
}

void myLinkedListDeleteAtIndex(MyLinkedList* obj, int index) {
    if (index < 0 || index >= obj->size) return;

    MyLinkedListNode* toDelete;
    if (index == 0) {
        toDelete = obj->head;
        obj->head = obj->head->next;
    } else {
        MyLinkedListNode* current = obj->head;
        for (int i = 0; i < index - 1; i++) {
            current = current->next;
        }
        toDelete = current->next;
        current->next = toDelete->next;
    }

    free(toDelete);
    obj->size--;
}

void myLinkedListFree(MyLinkedList* obj) {
    MyLinkedListNode* current = obj->head;
    while (current != NULL) {
        MyLinkedListNode* next = current->next;
        free(current);
        current = next;
    }
    free(obj);
}