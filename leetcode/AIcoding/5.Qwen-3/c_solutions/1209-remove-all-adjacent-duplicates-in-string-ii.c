#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeDuplicates(char* s, int k) {
    int len = strlen(s);
    char* stack = (char*)malloc((len + 1) * sizeof(char));
    int* count = (int*)malloc((len + 1) * sizeof(int));
    int top = -1;

    for (int i = 0; i < len; ++i) {
        if (top >= 0 && stack[top] == s[i]) {
            count[top]++;
            if (count[top] == k) {
                top--;
            }
        } else {
            top++;
            stack[top] = s[i];
            count[top] = 1;
        }
    }

    char* result = (char*)malloc((top + 1) * sizeof(char));
    for (int i = 0; i <= top; ++i) {
        result[i] = stack[i];
    }
    result[top + 1] = '\0';

    free(stack);
    free(count);

    return result;
}