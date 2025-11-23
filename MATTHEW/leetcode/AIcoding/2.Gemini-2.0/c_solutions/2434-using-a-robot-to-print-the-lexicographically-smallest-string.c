#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* robotWithString(char* s) {
    int n = strlen(s);
    int* suffix_min = (int*)malloc(n * sizeof(int));
    suffix_min[n - 1] = s[n - 1];
    for (int i = n - 2; i >= 0; i--) {
        suffix_min[i] = (s[i] < suffix_min[i + 1]) ? s[i] : suffix_min[i + 1];
    }

    char* result = (char*)malloc((n + 1) * sizeof(char));
    int result_index = 0;
    char* stack = (char*)malloc((n + 1) * sizeof(char));
    int stack_index = 0;

    for (int i = 0; i < n; i++) {
        stack[stack_index++] = s[i];
        while (stack_index > 0 && stack[stack_index - 1] <= suffix_min[i]) {
            result[result_index++] = stack[stack_index - 1];
            stack_index--;
        }
    }

    while (stack_index > 0) {
        result[result_index++] = stack[stack_index - 1];
        stack_index--;
    }

    result[result_index] = '\0';

    free(suffix_min);
    free(stack);
    return result;
}