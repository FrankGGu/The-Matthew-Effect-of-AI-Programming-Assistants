#include <stdlib.h>
#include <string.h>

char *removeKdigits(char *num, int k) {
    int n = strlen(num);
    char *stack = (char *)malloc(sizeof(char) * (n + 1));
    int top = 0;

    for (int i = 0; i < n; i++) {
        char current_digit = num[i];
        while (top > 0 && k > 0 && stack[top - 1] > current_digit) {
            top--;
            k--;
        }
        stack[top++] = current_digit;
    }

    top -= k;
    if (top < 0) {
        top = 0;
    }

    int start_idx = 0;
    while (start_idx < top && stack[start_idx] == '0') {
        start_idx++;
    }

    int effective_len = top - start_idx;

    char *result;
    if (effective_len == 0) {
        result = (char *)malloc(sizeof(char) * 2);
        result[0] = '0';
        result[1] = '\0';
    } else {
        result = (char *)malloc(sizeof(char) * (effective_len + 1));
        strncpy(result, stack + start_idx, effective_len);
        result[effective_len] = '\0';
    }

    free(stack);
    return result;
}