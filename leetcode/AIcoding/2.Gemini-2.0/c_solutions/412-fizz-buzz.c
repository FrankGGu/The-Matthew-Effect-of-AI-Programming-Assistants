#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** fizzBuzz(int n, int* returnSize) {
    *returnSize = n;
    char** result = (char**)malloc(n * sizeof(char*));
    for (int i = 1; i <= n; i++) {
        if (i % 3 == 0 && i % 5 == 0) {
            result[i - 1] = "FizzBuzz";
        } else if (i % 3 == 0) {
            result[i - 1] = "Fizz";
        } else if (i % 5 == 0) {
            result[i - 1] = "Buzz";
        } else {
            char* str = (char*)malloc(10 * sizeof(char));
            sprintf(str, "%d", i);
            result[i - 1] = str;
        }
    }
    return result;
}