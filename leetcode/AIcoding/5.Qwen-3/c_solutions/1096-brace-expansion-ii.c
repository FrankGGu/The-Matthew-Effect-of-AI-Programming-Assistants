#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** data;
    int size;
    int capacity;
} StringSet;

void initStringSet(StringSet* set) {
    set->data = NULL;
    set->size = 0;
    set->capacity = 0;
}

void freeStringSet(StringSet* set) {
    for (int i = 0; i < set->size; i++) {
        free(set->data[i]);
    }
    free(set->data);
}

void addToStringSet(StringSet* set, const char* str) {
    for (int i = 0; i < set->size; i++) {
        if (strcmp(set->data[i], str) == 0) return;
    }
    if (set->size == set->capacity) {
        set->capacity = set->capacity ? set->capacity * 2 : 1;
        set->data = (char**)realloc(set->data, set->capacity * sizeof(char*));
    }
    set->data[set->size] = strdup(str);
    set->size++;
}

char** expand(char* s, int* returnSize) {
    int n = strlen(s);
    char** result = NULL;
    int resultSize = 0;
    int resultCapacity = 0;

    char** stack = (char**)malloc(n * sizeof(char*));
    int top = -1;

    for (int i = 0; i < n; i++) {
        if (s[i] == '{') {
            stack[++top] = strdup(s + i);
            i = strchr(stack[top], '}') - s;
        } else if (s[i] == '}') {
            char* part = stack[top--];
            char* start = part;
            char* end = strchr(part, '}');
            *end = '\0';
            char* temp = strdup(start);
            char* token = strtok(temp, ",");
            StringSet set;
            initStringSet(&set);
            while (token) {
                addToStringSet(&set, token);
                token = strtok(NULL, ",");
            }
            free(temp);
            free(part);
            char** newResult = (char**)malloc(set.size * sizeof(char*));
            for (int j = 0; j < set.size; j++) {
                newResult[j] = strdup(set.data[j]);
            }
            freeStringSet(&set);
            if (resultSize > 0) {
                char** combined = (char**)malloc(resultSize * set.size * sizeof(char*));
                int k = 0;
                for (int j = 0; j < resultSize; j++) {
                    for (int l = 0; l < set.size; l++) {
                        char* combinedStr = (char*)malloc(strlen(result[j]) + strlen(newResult[l]) + 1);
                        strcpy(combinedStr, result[j]);
                        strcat(combinedStr, newResult[l]);
                        combined[k++] = combinedStr;
                    }
                }
                for (int j = 0; j < resultSize; j++) free(result[j]);
                free(result);
                result = combined;
                resultSize = k;
            } else {
                result = newResult;
                resultSize = set.size;
            }
        } else if (s[i] == ',') {
            continue;
        } else {
            char* temp = (char*)malloc(2);
            temp[0] = s[i];
            temp[1] = '\0';
            if (resultSize > 0) {
                char** newResult = (char**)malloc(resultSize * sizeof(char*));
                for (int j = 0; j < resultSize; j++) {
                    char* combined = (char*)malloc(strlen(result[j]) + 2);
                    strcpy(combined, result[j]);
                    strcat(combined, temp);
                    newResult[j] = combined;
                }
                for (int j = 0; j < resultSize; j++) free(result[j]);
                free(result);
                result = newResult;
            } else {
                result = (char**)malloc(sizeof(char*));
                result[0] = temp;
                resultSize = 1;
            }
        }
    }

    if (top >= 0) {
        char* part = stack[top];
        char* start = part;
        char* end = strchr(part, '}');
        *end = '\0';
        char* temp = strdup(start);
        char* token = strtok(temp, ",");
        StringSet set;
        initStringSet(&set);
        while (token) {
            addToStringSet(&set, token);
            token = strtok(NULL, ",");
        }
        free(temp);
        free(part);
        char** newResult = (char**)malloc(set.size * sizeof(char*));
        for (int j = 0; j < set.size; j++) {
            newResult[j] = strdup(set.data[j]);
        }
        freeStringSet(&set);
        if (resultSize > 0) {
            char** combined = (char**)malloc(resultSize * set.size * sizeof(char*));
            int k = 0;
            for (int j = 0; j < resultSize; j++) {
                for (int l = 0; l < set.size; l++) {
                    char* combinedStr = (char*)malloc(strlen(result[j]) + strlen(newResult[l]) + 1);
                    strcpy(combinedStr, result[j]);
                    strcat(combinedStr, newResult[l]);
                    combined[k++] = combinedStr;
                }
            }
            for (int j = 0; j < resultSize; j++) free(result[j]);
            free(result);
            result = combined;
            resultSize = k;
        } else {
            result = newResult;
            resultSize = set.size;
        }
    }

    *returnSize = resultSize;
    return result;
}