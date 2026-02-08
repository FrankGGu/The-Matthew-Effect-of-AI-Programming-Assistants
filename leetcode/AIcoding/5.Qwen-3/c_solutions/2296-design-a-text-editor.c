#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* text;
    int capacity;
    int length;
} TextEditor;

TextEditor* textEditorCreate() {
    TextEditor* editor = (TextEditor*)malloc(sizeof(TextEditor));
    editor->text = (char*)malloc(1 * sizeof(char));
    editor->text[0] = '\0';
    editor->capacity = 1;
    editor->length = 0;
    return editor;
}

void textEditorDeleteText(TextEditor* obj, int k) {
    if (k >= obj->length) {
        free(obj->text);
        obj->text = (char*)malloc(1 * sizeof(char));
        obj->text[0] = '\0';
        obj->capacity = 1;
        obj->length = 0;
        return;
    }
    memmove(obj->text, obj->text + k, (obj->length - k + 1) * sizeof(char));
    obj->length -= k;
}

void textEditorAddText(TextEditor* obj, char* text) {
    int len = strlen(text);
    if (obj->length + len >= obj->capacity) {
        int newCapacity = obj->capacity;
        while (obj->length + len >= newCapacity) {
            newCapacity *= 2;
        }
        obj->text = (char*)realloc(obj->text, newCapacity * sizeof(char));
        obj->capacity = newCapacity;
    }
    memcpy(obj->text + obj->length, text, len * sizeof(char));
    obj->length += len;
    obj->text[obj->length] = '\0';
}

char* textEditorGetText(TextEditor* obj) {
    char* result = (char*)malloc((obj->length + 1) * sizeof(char));
    memcpy(result, obj->text, (obj->length + 1) * sizeof(char));
    return result;
}

void textEditorCursorLeft(TextEditor* obj, int k) {
    if (k >= obj->length) {
        obj->length = 0;
    } else {
        obj->length -= k;
    }
}

void textEditorCursorRight(TextEditor* obj, int k) {
    if (obj->length + k <= strlen(obj->text)) {
        obj->length += k;
    }
}

void textEditorFree(TextEditor* obj) {
    free(obj->text);
    free(obj);
}