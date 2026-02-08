#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** find_sequence(char* s, int* returnSize) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == ' ') {
            count++;
        }
    }
    count++;

    char** result = (char**)malloc(count * sizeof(char*));
    *returnSize = count;

    int start = 0;
    int idx = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == ' ') {
            int len = i - start;
            result[idx] = (char*)malloc((len + 1) * sizeof(char));
            strncpy(result[idx], s + start, len);
            result[idx][len] = '\0';
            start = i + 1;
            idx++;
        }
    }
    int len = n - start;
    result[idx] = (char*)malloc((len + 1) * sizeof(char));
    strncpy(result[idx], s + start, len);
    result[idx][len] = '\0';

    return result;
}