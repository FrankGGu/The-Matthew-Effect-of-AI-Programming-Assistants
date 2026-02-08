#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 1000

typedef struct {
    char **data;
    int size;
    int capacity;
} StringSet;

StringSet* stringSetCreate() {
    StringSet* set = (StringSet*)malloc(sizeof(StringSet));
    set->data = (char**)malloc(sizeof(char*) * 1);
    set->size = 0;
    set->capacity = 1;
    return set;
}

void stringSetAdd(StringSet* set, char* str) {
    for (int i = 0; i < set->size; i++) {
        if (strcmp(set->data[i], str) == 0) {
            return;
        }
    }

    if (set->size == set->capacity) {
        set->capacity *= 2;
        set->data = (char**)realloc(set->data, sizeof(char*) * set->capacity);
    }

    set->data[set->size] = strdup(str);
    set->size++;
}

void stringSetFree(StringSet* set) {
    for (int i = 0; i < set->size; i++) {
        free(set->data[i]);
    }
    free(set->data);
    free(set);
}

int stringSetCompare(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

char** braceExpansionII(char* expression, int* returnSize) {
    StringSet* set = stringSetCreate();

    typedef struct {
        int start;
        int end;
    } Range;

    typedef struct {
        StringSet* set;
        int index;
    } StackItem;

    typedef struct {
        StackItem* items;
        int size;
        int capacity;
    } Stack;

    Stack* stackCreate() {
        Stack* stack = (Stack*)malloc(sizeof(Stack));
        stack->items = (StackItem*)malloc(sizeof(StackItem) * 1);
        stack->size = 0;
        stack->capacity = 1;
        return stack;
    }

    void stackPush(Stack* stack, StringSet* set, int index) {
        if (stack->size == stack->capacity) {
            stack->capacity *= 2;
            stack->items = (StackItem*)realloc(stack->items, sizeof(StackItem) * stack->capacity);
        }
        stack->items[stack->size].set = set;
        stack->items[stack->size].index = index;
        stack->size++;
    }

    StackItem stackPop(Stack* stack) {
        stack->size--;
        return stack->items[stack->size];
    }

    int stackIsEmpty(Stack* stack) {
        return stack->size == 0;
    }

    void stackFree(Stack* stack) {
        free(stack->items);
        free(stack);
    }

    Stack* stack = stackCreate();
    stackPush(stack, set, 0);

    for (int i = 0; i < strlen(expression); i++) {
        if (expression[i] == '{') {
            StringSet* newSet = stringSetCreate();
            stackPush(stack, newSet, i + 1);
        } else if (expression[i] == ',') {
            stackPush(stack, stringSetCreate(), i + 1);
        } else if (expression[i] == '}') {
            StringSet* currentSet = stackPop(stack).set;
            StringSet* parentSet = stackPop(stack).set;

            for (int j = 0; j < parentSet->size; j++) {
                for (int k = 0; k < currentSet->size; k++) {
                    char* newStr = (char*)malloc(sizeof(char) * (strlen(parentSet->data[j]) + strlen(currentSet->data[k]) + 1));
                    strcpy(newStr, parentSet->data[j]);
                    strcat(newStr, currentSet->data[k]);
                    stringSetAdd(set, newStr);
                }
                if (currentSet->size == 0) {
                    stringSetAdd(set, strdup(parentSet->data[j]));
                }
            }

            if (parentSet->size == 0) {
                for (int k = 0; k < currentSet->size; k++) {
                    stringSetAdd(set, strdup(currentSet->data[k]));
                }
            }

            stringSetFree(currentSet);
            stackPush(stack, set, i + 1);
            set = stringSetCreate();
        } else {
            int j = i;
            while (j < strlen(expression) && expression[j] != '{' && expression[j] != '}' && expression[j] != ',') {
                j++;
            }
            char* str = (char*)malloc(sizeof(char) * (j - i + 1));
            strncpy(str, expression + i, j - i);
            str[j - i] = '\0';
            StringSet* currentSet = stackPop(stack).set;
            if (currentSet->size == 0) {
                stringSetAdd(set, str);
            } else {
                for (int k = 0; k < currentSet->size; k++) {
                    char* newStr = (char*)malloc(sizeof(char) * (strlen(currentSet->data[k]) + strlen(str) + 1));
                    strcpy(newStr, currentSet->data[k]);
                    strcat(newStr, str);
                    stringSetAdd(set, newStr);
                }
                stringSetFree(currentSet);
            }
            stackPush(stack, set, j);
            set = stringSetCreate();
            i = j - 1;
        }
    }

    while (!stackIsEmpty(stack)) {
        StringSet* currentSet = stackPop(stack).set;
        for (int k = 0; k < currentSet->size; k++) {
            stringSetAdd(set, currentSet->data[k]);
        }
        stringSetFree(currentSet);
    }

    stackFree(stack);

    qsort(set->data, set->size, sizeof(char*), stringSetCompare);

    *returnSize = set->size;
    return set->data;
}