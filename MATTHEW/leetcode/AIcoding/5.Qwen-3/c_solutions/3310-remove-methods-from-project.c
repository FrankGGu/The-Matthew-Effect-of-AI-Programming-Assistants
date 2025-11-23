#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int start;
    int end;
} Method;

typedef struct {
    char* line;
    int index;
} LineInfo;

char** removeMethods(char** source, int sourceSize, char** methods, int methodsSize, int* returnSize) {
    Method* methodList = (Method*)malloc(methodsSize * sizeof(Method));
    for (int i = 0; i < methodsSize; i++) {
        methodList[i].name = methods[i];
        methodList[i].start = -1;
        methodList[i].end = -1;
    }

    LineInfo* lines = (LineInfo*)malloc(sourceSize * sizeof(LineInfo));
    for (int i = 0; i < sourceSize; i++) {
        lines[i].line = source[i];
        lines[i].index = i;
    }

    for (int i = 0; i < methodsSize; i++) {
        char* methodName = methodList[i].name;
        for (int j = 0; j < sourceSize; j++) {
            char* line = source[j];
            char* pos = strstr(line, methodName);
            if (pos != NULL) {
                methodList[i].start = j;
                methodList[i].end = j;
                break;
            }
        }
    }

    for (int i = 0; i < methodsSize; i++) {
        if (methodList[i].start == -1) continue;
        for (int j = methodList[i].start + 1; j < sourceSize; j++) {
            char* line = source[j];
            if (strstr(line, "}") != NULL) {
                methodList[i].end = j;
                break;
            }
        }
    }

    int* toRemove = (int*)calloc(sourceSize, sizeof(int));
    for (int i = 0; i < methodsSize; i++) {
        if (methodList[i].start == -1) continue;
        for (int j = methodList[i].start; j <= methodList[i].end; j++) {
            toRemove[j] = 1;
        }
    }

    int count = 0;
    for (int i = 0; i < sourceSize; i++) {
        if (!toRemove[i]) count++;
    }

    char** result = (char**)malloc(count * sizeof(char*));
    int idx = 0;
    for (int i = 0; i < sourceSize; i++) {
        if (!toRemove[i]) {
            result[idx++] = strdup(source[i]);
        }
    }

    *returnSize = count;
    free(toRemove);
    free(methodList);
    free(lines);
    return result;
}