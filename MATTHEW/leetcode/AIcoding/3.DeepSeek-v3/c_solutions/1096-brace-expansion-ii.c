#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char** data;
    int size;
    int capacity;
} List;

List* createList() {
    List* list = (List*)malloc(sizeof(List));
    list->data = NULL;
    list->size = 0;
    list->capacity = 0;
    return list;
}

void appendToList(List* list, char* str) {
    if (list->size >= list->capacity) {
        list->capacity = list->capacity == 0 ? 4 : list->capacity * 2;
        list->data = (char**)realloc(list->data, list->capacity * sizeof(char*));
    }
    list->data[list->size++] = str;
}

List* merge(List* a, List* b) {
    List* res = createList();
    for (int i = 0; i < a->size; i++) {
        for (int j = 0; j < b->size; j++) {
            char* newStr = (char*)malloc(strlen(a->data[i]) + strlen(b->data[j]) + 1);
            strcpy(newStr, a->data[i]);
            strcat(newStr, b->data[j]);
            appendToList(res, newStr);
        }
    }
    return res;
}

List* add(List* a, List* b) {
    for (int i = 0; i < b->size; i++) {
        appendToList(a, b->data[i]);
    }
    free(b->data);
    free(b);
    return a;
}

List* braceExpansionII(char* expression) {
    List** stack = (List**)malloc(1000 * sizeof(List*));
    int stackSize = 0;

    List* res = createList();
    List* cur = createList();
    appendToList(cur, "");

    for (int i = 0; expression[i]; i++) {
        if (expression[i] == '{') {
            appendToList(stack, cur);
            appendToList(stack, res);
            res = createList();
            cur = createList();
            appendToList(cur, "");
        } else if (expression[i] == '}') {
            List* preCur = stack[--stackSize];
            List* preRes = stack[--stackSize];
            res = add(res, cur);
            cur = merge(preCur, res);
            res = preRes;
        } else if (expression[i] == ',') {
            res = add(res, cur);
            cur = createList();
            appendToList(cur, "");
        } else {
            List* newCur = createList();
            for (int j = 0; j < cur->size; j++) {
                int len = strlen(cur->data[j]);
                char* newStr = (char*)malloc(len + 2);
                strcpy(newStr, cur->data[j]);
                newStr[len] = expression[i];
                newStr[len + 1] = '\0';
                appendToList(newCur, newStr);
            }
            free(cur->data);
            free(cur);
            cur = newCur;
        }
    }

    res = add(res, cur);

    char** arr = res->data;
    int n = res->size;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (strcmp(arr[i], arr[j]) > 0) {
                char* temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }

    int k = 0;
    for (int i = 0; i < n; i++) {
        if (i == 0 || strcmp(arr[i], arr[i - 1]) != 0) {
            arr[k++] = arr[i];
        } else {
            free(arr[i]);
        }
    }

    res->size = k;

    free(stack);
    return res;
}