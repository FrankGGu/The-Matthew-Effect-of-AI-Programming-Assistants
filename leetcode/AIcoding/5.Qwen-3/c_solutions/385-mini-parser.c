#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct NestedInteger {
    int isInteger;
    int value;
    struct NestedInteger** list;
    int listSize;
} NestedInteger;

NestedInteger* createInteger(int value) {
    NestedInteger* node = (NestedInteger*)malloc(sizeof(NestedInteger));
    node->isInteger = 1;
    node->value = value;
    node->list = NULL;
    node->listSize = 0;
    return node;
}

NestedInteger* createList() {
    NestedInteger* node = (NestedInteger*)malloc(sizeof(NestedInteger));
    node->isInteger = 0;
    node->value = 0;
    node->list = NULL;
    node->listSize = 0;
    return node;
}

void addToList(NestedInteger* list, NestedInteger* element) {
    list->list = (NestedInteger**)realloc(list->list, sizeof(NestedInteger*) * (list->listSize + 1));
    list->list[list->listSize++] = element;
}

NestedInteger* deserialize(char* s) {
    if (!s || s[0] != '[') {
        return createInteger(atoi(s));
    }

    NestedInteger* root = createList();
    int i = 1;
    while (i < strlen(s) - 1) {
        if (s[i] == '[') {
            int depth = 1;
            int j = i + 1;
            while (depth > 0 && j < strlen(s)) {
                if (s[j] == '[') depth++;
                else if (s[j] == ']') depth--;
                j++;
            }
            char* sub = (char*)malloc(j - i);
            strncpy(sub, &s[i], j - i - 1);
            sub[j - i - 1] = '\0';
            addToList(root, deserialize(sub));
            free(sub);
            i = j;
        } else if (s[i] == ',') {
            i++;
        } else {
            int j = i;
            while (j < strlen(s) && (s[j] >= '0' && s[j] <= '9' || s[j] == '-')) j++;
            char* num = (char*)malloc(j - i + 1);
            strncpy(num, &s[i], j - i);
            num[j - i] = '\0';
            addToList(root, createInteger(atoi(num)));
            free(num);
            i = j;
        }
    }
    return root;
}