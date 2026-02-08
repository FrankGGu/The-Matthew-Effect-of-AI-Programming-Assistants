#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** fizzBuzz(int n, int* returnSize) {
    char** result = (char**)malloc(n * sizeof(char*));
    for (int i = 1; i <= n; i++) {
        char* str = (char*)malloc(16 * sizeof(char));
        if (i % 3 == 0 && i % 5 == 0) {
            strcpy(str, "FizzBuzz");
        } else if (i % 3 == 0) {
            strcpy(str, "Fizz");
        } else if (i % 5 == 0) {
            strcpy(str, "Buzz");
        } else {
            sprintf(str, "%d", i);
        }
        result[i - 1] = str;
    }
    *returnSize = n;
    return result;
}