#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *text;
    int cursor;
    int size;
    int capacity;
} TextEditor;

TextEditor* textEditorCreate() {
    TextEditor* editor = (TextEditor*)malloc(sizeof(TextEditor));
    editor->capacity = 16;
    editor->text = (char*)malloc(editor->capacity * sizeof(char));
    editor->text[0] = '\0';
    editor->cursor = 0;
    editor->size = 0;
    return editor;
}

void textEditorAddText(TextEditor* obj, char *text) {
    int len = strlen(text);
    if (obj->size + len >= obj->capacity) {
        obj->capacity = (obj->size + len) * 2;
        obj->text = (char*)realloc(obj->text, obj->capacity * sizeof(char));
    }
    memmove(obj->text + obj->cursor + len, obj->text + obj->cursor, (obj->size - obj->cursor) + 1);
    memcpy(obj->text + obj->cursor, text, len);
    obj->cursor += len;
    obj->size += len;
}

int textEditorDeleteText(TextEditor* obj, int k) {
    int delete_count = 0;
    if (k > 0) {
        delete_count = (k <= obj->cursor) ? k : obj->cursor;
        memmove(obj->text + obj->cursor - delete_count, obj->text + obj->cursor, (obj->size - obj->cursor) + 1);
        obj->cursor -= delete_count;
        obj->size -= delete_count;
        obj->text[obj->size] = '\0';
    }
    return delete_count;
}

char *textEditorCursorLeft(TextEditor* obj, int k) {
    if (k > 0) {
        obj->cursor = (k <= obj->cursor) ? (obj->cursor - k) : 0;
    }
    int start = (obj->cursor >= 10) ? (obj->cursor - 10) : 0;
    int len = obj->cursor - start;
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strncpy(result, obj->text + start, len);
    result[len] = '\0';
    return result;
}

char *textEditorCursorRight(TextEditor* obj, int k) {
    if (k > 0) {
        obj->cursor = (k <= (obj->size - obj->cursor)) ? (obj->cursor + k) : obj->size;
    }
    int start = (obj->cursor >= 10) ? (obj->cursor - 10) : 0;
    int len = obj->cursor - start;
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strncpy(result, obj->text + start, len);
    result[len] = '\0';
    return result;
}

void textEditorFree(TextEditor* obj) {
    free(obj->text);
    free(obj);
}