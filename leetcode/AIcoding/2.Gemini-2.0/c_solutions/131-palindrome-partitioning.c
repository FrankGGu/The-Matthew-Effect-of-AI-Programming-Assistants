#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** data;
    int size;
    int capacity;
} StringArray;

void initStringArray(StringArray* arr) {
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

void addString(StringArray* arr, const char* str) {
    if (arr->size == arr->capacity) {
        arr->capacity = (arr->capacity == 0) ? 1 : arr->capacity * 2;
        arr->data = (char**)realloc(arr->data, arr->capacity * sizeof(char*));
    }
    arr->data[arr->size] = strdup(str);
    arr->size++;
}

void freeStringArray(StringArray* arr) {
    for (int i = 0; i < arr->size; i++) {
        free(arr->data[i]);
    }
    free(arr->data);
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

typedef struct {
    StringArray* data;
    int size;
    int capacity;
} ResultArray;

void initResultArray(ResultArray* arr) {
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

void addStringArray(ResultArray* arr, StringArray* strArr) {
    if (arr->size == arr->capacity) {
        arr->capacity = (arr->capacity == 0) ? 1 : arr->capacity * 2;
        arr->data = (StringArray*)realloc(arr->data, arr->capacity * sizeof(StringArray));
    }
    arr->data[arr->size] = *strArr;
    arr->size++;
}

void freeResultArray(ResultArray* arr) {
    for (int i = 0; i < arr->size; i++) {
        freeStringArray(&arr->data[i]);
    }
    free(arr->data);
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

bool isPalindrome(char* s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

void backtrack(char* s, int start, StringArray* currentList, ResultArray* result) {
    if (start == strlen(s)) {
        StringArray newList;
        initStringArray(&newList);
        for (int i = 0; i < currentList->size; i++) {
            addString(&newList, currentList->data[i]);
        }
        addStringArray(result, &newList);
        return;
    }

    for (int i = start; i < strlen(s); i++) {
        if (isPalindrome(s, start, i)) {
            char* sub = (char*)malloc((i - start + 2) * sizeof(char));
            strncpy(sub, s + start, i - start + 1);
            sub[i - start + 1] = '\0';

            addString(currentList, sub);
            backtrack(s, i + 1, currentList, result);
            currentList->size--;
            free(sub);
        }
    }
}

char*** partition(char* s, int* returnSize, int** returnColumnSizes) {
    ResultArray result;
    initResultArray(&result);

    StringArray currentList;
    initStringArray(&currentList);

    backtrack(s, 0, &currentList, &result);
    freeStringArray(&currentList);

    *returnSize = result.size;
    *returnColumnSizes = (int*)malloc(result.size * sizeof(int));
    char*** finalResult = (char***)malloc(result.size * sizeof(char**));

    for (int i = 0; i < result.size; i++) {
        (*returnColumnSizes)[i] = result.data[i].size;
        finalResult[i] = (char**)malloc(result.data[i].size * sizeof(char*));
        for (int j = 0; j < result.data[i].size; j++) {
            finalResult[i][j] = strdup(result.data[i].data[j]);
        }
    }

    freeResultArray(&result);

    return finalResult;
}