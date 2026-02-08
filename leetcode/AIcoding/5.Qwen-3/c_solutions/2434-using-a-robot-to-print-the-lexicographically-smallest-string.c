#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* robotWithString(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int resultIndex = 0;
    int* stack = (int*)malloc(len * sizeof(int));
    int stackSize = 0;

    int* minSuffix = (int*)malloc(len * sizeof(int));
    minSuffix[len - 1] = len - 1;

    for (int i = len - 2; i >= 0; i--) {
        if (s[i] <= s[minSuffix[i + 1]]) {
            minSuffix[i] = i;
        } else {
            minSuffix[i] = minSuffix[i + 1];
        }
    }

    int currentMinIndex = 0;

    for (int i = 0; i < len; i++) {
        while (stackSize > 0 && s[stack[stackSize - 1]] <= s[currentMinIndex]) {
            result[resultIndex++] = s[stack[stackSize - 1]];
            stackSize--;
        }

        stack[stackSize++] = i;

        if (currentMinIndex == i) {
            currentMinIndex = minSuffix[i];
        }
    }

    while (stackSize > 0) {
        result[resultIndex++] = s[stack[stackSize - 1]];
        stackSize--;
    }

    result[resultIndex] = '\0';
    free(stack);
    free(minSuffix);
    return result;
}