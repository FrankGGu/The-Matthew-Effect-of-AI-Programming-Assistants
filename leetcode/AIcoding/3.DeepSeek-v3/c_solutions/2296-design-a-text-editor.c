typedef struct Node {
    char ch;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct {
    Node* cursor;
    int size;
} TextEditor;

TextEditor* textEditorCreate() {
    TextEditor* obj = (TextEditor*)malloc(sizeof(TextEditor));
    obj->cursor = NULL;
    obj->size = 0;
    return obj;
}

void textEditorAddText(TextEditor* obj, char* text) {
    for (int i = 0; text[i]; i++) {
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->ch = text[i];
        if (obj->cursor == NULL) {
            newNode->prev = NULL;
            newNode->next = NULL;
            obj->cursor = newNode;
        } else {
            Node* nextNode = obj->cursor->next;
            newNode->prev = obj->cursor;
            newNode->next = nextNode;
            obj->cursor->next = newNode;
            if (nextNode) nextNode->prev = newNode;
            obj->cursor = newNode;
        }
        obj->size++;
    }
}

int textEditorDeleteText(TextEditor* obj, int k) {
    int deleted = 0;
    while (k > 0 && obj->cursor != NULL) {
        Node* toDelete = obj->cursor;
        obj->cursor = obj->cursor->prev;
        if (obj->cursor) obj->cursor->next = toDelete->next;
        if (toDelete->next) toDelete->next->prev = obj->cursor;
        free(toDelete);
        k--;
        deleted++;
        obj->size--;
    }
    return deleted;
}

char* textEditorCursorLeft(TextEditor* obj, int k) {
    while (k > 0 && obj->cursor != NULL) {
        obj->cursor = obj->cursor->prev;
        k--;
    }
    return textEditorGetLeftText(obj);
}

char* textEditorCursorRight(TextEditor* obj, int k) {
    while (k > 0 && obj->cursor != NULL && obj->cursor->next != NULL) {
        obj->cursor = obj->cursor->next;
        k--;
    }
    return textEditorGetLeftText(obj);
}

char* textEditorGetLeftText(TextEditor* obj) {
    char* result = (char*)malloc(11 * sizeof(char));
    int count = 0;
    Node* temp = obj->cursor;
    while (temp != NULL && count < 10) {
        result[9 - count] = temp->ch;
        temp = temp->prev;
        count++;
    }
    result[10] = '\0';
    return result + (10 - count);
}

void textEditorFree(TextEditor* obj) {
    Node* current = obj->cursor;
    while (current && current->prev) current = current->prev;
    while (current) {
        Node* next = current->next;
        free(current);
        current = next;
    }
    free(obj);
}