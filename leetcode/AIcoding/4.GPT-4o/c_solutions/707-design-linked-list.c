typedef struct Node {
    int val;
    struct Node* next;
} Node;

typedef struct MyLinkedList {
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
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = obj->head;
    obj->head = newNode;
    obj->size++;
}

void myLinkedListAddAtTail(MyLinkedList* obj, int val) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = NULL;
    if (obj->head == NULL) {
        obj->head = newNode;
    } else {
        Node* current = obj->head;
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = newNode;
    }
    obj->size++;
}

void myLinkedListAddAtIndex(MyLinkedList* obj, int index, int val) {
    if (index > obj->size) return;
    if (index <= 0) {
        myLinkedListAddAtHead(obj, val);
    } else if (index == obj->size) {
        myLinkedListAddAtTail(obj, val);
    } else {
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->val = val;
        Node* current = obj->head;
        for (int i = 0; i < index - 1; i++) {
            current = current->next;
        }
        newNode->next = current->next;
        current->next = newNode;
        obj->size++;
    }
}

void myLinkedListDeleteAtIndex(MyLinkedList* obj, int index) {
    if (index < 0 || index >= obj->size) return;
    if (index == 0) {
        Node* temp = obj->head;
        obj->head = obj->head->next;
        free(temp);
    } else {
        Node* current = obj->head;
        for (int i = 0; i < index - 1; i++) {
            current = current->next;
        }
        Node* temp = current->next;
        current->next = current->next->next;
        free(temp);
    }
    obj->size--;
}

void myLinkedListFree(MyLinkedList* obj) {
    Node* current = obj->head;
    while (current != NULL) {
        Node* temp = current;
        current = current->next;
        free(temp);
    }
    free(obj);
}