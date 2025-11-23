#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* lastRemaining(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int len = n;
    for (int i = 0; i < n; i++) {
        result[i] = 'a' + i;
    }
    result[n] = '\0';

    int index = 0;
    while (len > 1) {
        index = (index + k - 1) % len;
        memmove(result + index, result + index + 1, (len - index - 1) * sizeof(char));
        len--;
    }
    return result;
}