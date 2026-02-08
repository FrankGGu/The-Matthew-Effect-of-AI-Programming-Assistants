#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* get_key(char* s) {
    int len = strlen(s);
    char* key = (char*)malloc((len + 1) * sizeof(char));
    int i, j;
    for (i = 0; i < len; i += 2) {
        key[i] = s[i];
    }
    for (i = 1; i < len; i += 2) {
        key[i] = s[i];
    }
    qsort(key, len, sizeof(char), (int(*)(const void*, const void*))strcmp);
    return key;
}

int numSpecialEquivalent(char** A, int ASize) {
    int count = 0;
    int* used = (int*)calloc(ASize, sizeof(int));
    for (int i = 0; i < ASize; i++) {
        if (used[i]) continue;
        count++;
        char* key = get_key(A[i]);
        for (int j = i + 1; j < ASize; j++) {
            if (used[j]) continue;
            char* j_key = get_key(A[j]);
            if (strcmp(key, j_key) == 0) {
                used[j] = 1;
            }
            free(j_key);
        }
        free(key);
    }
    free(used);
    return count;
}