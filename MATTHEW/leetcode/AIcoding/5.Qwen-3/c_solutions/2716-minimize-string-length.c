#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimizeStringLength(char* s) {
    int len = strlen(s);
    int* seen = (int*)calloc(26, sizeof(int));
    int count = 0;

    for (int i = 0; i < len; i++) {
        int idx = s[i] - 'a';
        if (!seen[idx]) {
            seen[idx] = 1;
            count++;
        }
    }

    free(seen);
    return count;
}