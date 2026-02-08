#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeKdigits(char* num, int k) {
    int n = strlen(num);
    char* stack = (char*)malloc((n + 1) * sizeof(char));
    int top = 0;

    for (int i = 0; i < n; ++i) {
        while (top > 0 && k > 0 && stack[top - 1] > num[i]) {
            --top;
            --k;
        }
        stack[top++] = num[i];
    }

    while (k > 0 && top > 0) {
        --top;
        --k;
    }

    int i = 0;
    while (i < top && stack[i] == '0') {
        ++i;
    }

    if (i == top) {
        free(stack);
        return "0";
    }

    char* result = (char*)malloc((top - i + 1) * sizeof(char));
    strncpy(result, stack + i, top - i);
    result[top - i] = '\0';

    free(stack);
    return result;
}