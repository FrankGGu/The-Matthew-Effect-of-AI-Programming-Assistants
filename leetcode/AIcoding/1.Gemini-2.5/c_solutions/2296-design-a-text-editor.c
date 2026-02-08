#include <stdlib.h>
#include <string.h>

static inline int min(int a, int b) {
    return a < b ? a : b;
}

#define MIN_BUF_CAPACITY 16

static void ensure_capacity(char** buffer, int* current_size, int* current_capacity, int required_additional_space) {
    if (*current_size + required_additional_space > *current_capacity) {
        int new_capacity = *current_capacity;
        if (new_capacity == 0) {
            new_capacity = MIN_BUF_CAPACITY;
        }
        while (new_capacity < *current_size + required_additional_space) {
            if (new_capacity > (int)((unsigned int)-1 / 2)) { 
                 new_capacity = *current_size + required_additional_space;
                 break;
            }
            new_capacity *= 2;
        }
        *buffer = (char*)realloc(*buffer, new_capacity);
        *current_capacity = new_capacity;
    }
}

typedef struct {
    char* left_part;
    int left_size;
    int left_capacity;

    char* right_part;
    int right_size;
    int right_capacity;
} TextEditor;

TextEditor* textEditorCreate() {
    TextEditor* obj = (TextEditor*)malloc(sizeof(TextEditor));
    obj->left_size = 0;
    obj->left_capacity = MIN_BUF_CAPACITY;
    obj->left_part = (char*)malloc(obj->left_capacity);

    obj->right_size = 0;
    obj->right_capacity = MIN_BUF_CAPACITY;
    obj->right_part = (char*)malloc(obj->right_capacity);

    return obj;
}

void textEditorAddText(TextEditor* obj, char* text) {
    int text_len = strlen(text);
    ensure_capacity(&obj->left_part, &obj->left_size, &obj->left_capacity, text_len);
    memcpy(obj->left_part + obj->left_size, text, text_len);
    obj->left_size += text_len;
}

int textEditorDeleteText(TextEditor* obj, int k) {
    int deleted_count = min(k, obj->left_size);
    obj->left_size -= deleted_count;
    return deleted_count;
}

char* textEditorCursorLeft(TextEditor* obj, int k) {
    int move_count = min(k, obj->left_size);

    if (move_count > 0) {
        ensure_capacity(&obj->right_part, &obj->right_size, &obj->right_capacity, move_count);
        memmove(obj->right_part + move_count, obj->right_part, obj->right_size);
        memcpy(obj->right_part, obj->left_part + obj->left_size - move_count, move_count);
        obj->left_size -= move_count;
        obj->right_size += move_count;
    }

    int return_len = min(10, obj->left_size);
    char* result = (char*)malloc(return_len + 1);
    memcpy(result, obj->left_part + obj->left_size - return_len, return_len);
    result[return_len] = '\0';
    return result;
}

char* textEditorCursorRight(TextEditor* obj, int k) {
    int move_count = min(k, obj->right_size);

    if (move_count > 0) {
        ensure_capacity(&obj->left_part, &obj->left_size, &obj->left_capacity, move_count);
        memcpy(obj->left_part + obj->left_size, obj->right_part, move_count);
        memmove(obj->right_part, obj->right_part + move_count, obj->right_size - move_count);
        obj->left_size += move_count;
        obj->right_size -= move_count;
    }

    int return_len = min(10, obj->left_size);
    char* result = (char*)malloc(return_len + 1);
    memcpy(result, obj->left_part + obj->left_size - return_len, return_len);
    result[return_len] = '\0';
    return result;
}

void textEditorFree(TextEditor* obj) {
    free(obj->left_part);
    free(obj->right_part);
    free(obj);
}