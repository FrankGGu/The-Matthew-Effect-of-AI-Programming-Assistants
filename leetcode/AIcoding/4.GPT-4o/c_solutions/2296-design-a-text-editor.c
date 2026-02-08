typedef struct {
    char *text;
    int cursor;
    int capacity;
} TextEditor;

TextEditor* textEditorCreate() {
    TextEditor *editor = (TextEditor *)malloc(sizeof(TextEditor));
    editor->capacity = 1000;
    editor->text = (char *)malloc(editor->capacity * sizeof(char));
    editor->text[0] = '\0';
    editor->cursor = 0;
    return editor;
}

void textEditorAddText(TextEditor* editor, char* text) {
    int len = strlen(text);
    while (editor->cursor + len >= editor->capacity) {
        editor->capacity *= 2;
        editor->text = (char *)realloc(editor->text, editor->capacity * sizeof(char));
    }
    memmove(editor->text + editor->cursor + len, editor->text + editor->cursor, strlen(editor->text) - editor->cursor + 1);
    memcpy(editor->text + editor->cursor, text, len);
    editor->cursor += len;
}

int textEditorDeleteText(TextEditor* editor, int k) {
    int deleted = 0;
    if (k > editor->cursor) {
        deleted = editor->cursor;
        editor->cursor = 0;
    } else {
        deleted = k;
        editor->cursor -= k;
    }
    memmove(editor->text + editor->cursor, editor->text + editor->cursor + deleted, strlen(editor->text) - editor->cursor - deleted + 1);
    return deleted;
}

char* textEditorCursorLeft(TextEditor* editor, int k) {
    if (k > editor->cursor) {
        k = editor->cursor;
    }
    editor->cursor -= k;
    char *result = (char *)malloc(11 * sizeof(char));
    strncpy(result, editor->text + editor->cursor, 10);
    result[10] = '\0';
    return result;
}

char* textEditorCursorRight(TextEditor* editor, int k) {
    if (k > strlen(editor->text) - editor->cursor) {
        k = strlen(editor->text) - editor->cursor;
    }
    editor->cursor += k;
    char *result = (char *)malloc(11 * sizeof(char));
    strncpy(result, editor->text + editor->cursor - 10, 10);
    result[10] = '\0';
    return result;
}

void textEditorFree(TextEditor* editor) {
    free(editor->text);
    free(editor);
}