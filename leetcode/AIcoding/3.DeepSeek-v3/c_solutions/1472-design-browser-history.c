typedef struct Node {
    char* url;
    struct Node* next;
    struct Node* prev;
} Node;

typedef struct {
    Node* current;
} BrowserHistory;

BrowserHistory* browserHistoryCreate(char* homepage) {
    BrowserHistory* obj = (BrowserHistory*)malloc(sizeof(BrowserHistory));
    obj->current = (Node*)malloc(sizeof(Node));
    obj->current->url = homepage;
    obj->current->next = NULL;
    obj->current->prev = NULL;
    return obj;
}

void browserHistoryVisit(BrowserHistory* obj, char* url) {
    Node* newPage = (Node*)malloc(sizeof(Node));
    newPage->url = url;
    newPage->prev = obj->current;
    newPage->next = NULL;
    obj->current->next = newPage;
    obj->current = newPage;
}

char* browserHistoryBack(BrowserHistory* obj, int steps) {
    while (steps > 0 && obj->current->prev != NULL) {
        obj->current = obj->current->prev;
        steps--;
    }
    return obj->current->url;
}

char* browserHistoryForward(BrowserHistory* obj, int steps) {
    while (steps > 0 && obj->current->next != NULL) {
        obj->current = obj->current->next;
        steps--;
    }
    return obj->current->url;
}

void browserHistoryFree(BrowserHistory* obj) {
    Node* temp = obj->current;
    while (temp->prev != NULL) {
        temp = temp->prev;
    }
    while (temp != NULL) {
        Node* next = temp->next;
        free(temp);
        temp = next;
    }
    free(obj);
}