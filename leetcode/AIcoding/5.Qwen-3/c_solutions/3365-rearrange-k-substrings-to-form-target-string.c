#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* str;
    int len;
} String;

int compare(const void* a, const void* b) {
    return strcmp(((String*)a)->str, ((String*)b)->str);
}

char* rearrangeKSubstrings(char** target, int targetSize, char** kSubstrings, int kSubstringsSize) {
    int targetLen = 0;
    for (int i = 0; i < targetSize; i++) {
        targetLen += strlen(target[i]);
    }

    int totalLen = 0;
    for (int i = 0; i < kSubstringsSize; i++) {
        totalLen += strlen(kSubstrings[i]);
    }

    if (targetLen != totalLen) {
        return NULL;
    }

    String* substrings = (String*)malloc(kSubstringsSize * sizeof(String));
    for (int i = 0; i < kSubstringsSize; i++) {
        substrings[i].str = kSubstrings[i];
        substrings[i].len = strlen(kSubstrings[i]);
    }

    qsort(substrings, kSubstringsSize, sizeof(String), compare);

    char* result = (char*)malloc((targetLen + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < kSubstringsSize; i++) {
        strcpy(result + index, substrings[i].str);
        index += substrings[i].len;
    }

    result[index] = '\0';

    free(substrings);
    return result;
}