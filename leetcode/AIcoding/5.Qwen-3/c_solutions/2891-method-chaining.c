#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct MethodChaining {
    char* result;
} MethodChaining;

MethodChaining* method_chaining_create() {
    MethodChaining* obj = (MethodChaining*)malloc(sizeof(MethodChaining));
    obj->result = (char*)malloc(1);
    obj->result[0] = '\0';
    return obj;
}

void method_chaining_append(MethodChaining* obj, char* str) {
    int len = strlen(obj->result) + strlen(str) + 1;
    obj->result = (char*)realloc(obj->result, len);
    strcat(obj->result, str);
}

char* method_chaining_get(MethodChaining* obj) {
    return obj->result;
}

void method_chaining_free(MethodChaining* obj) {
    free(obj->result);
    free(obj);
}