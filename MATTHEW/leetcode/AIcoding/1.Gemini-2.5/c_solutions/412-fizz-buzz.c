#include <stdlib.h>
#include <string.h>
#include <stdio.h>

char ** fizzBuzz(int n, int* returnSize) {
    char **result = (char **)malloc(n * sizeof(char *));
    *returnSize = n;

    for (int i = 1; i <= n; i++) {
        if (i % 15 == 0) {
            result[i - 1] = (char *)malloc(9 * sizeof(char)); // "FizzBuzz\0"
            strcpy(result[i - 1], "FizzBuzz");
        } else if (i % 3 == 0) {
            result[i - 1] = (char *)malloc(5 * sizeof(char)); // "Fizz\0"
            strcpy(result[i - 1], "Fizz");
        } else if (i % 5 == 0) {
            result[i - 1] = (char *)malloc(5 * sizeof(char)); // "Buzz\0"
            strcpy(result[i - 1], "Buzz");
        } else {
            // Max digits for n=10^4 is 5, plus null terminator
            // For n=10^5, 6 digits. For n=10^9, 10 digits.
            // Problem constraints are n <= 10^4, so 5 digits + null is enough.
            result[i - 1] = (char *)malloc(12 * sizeof(char)); // Sufficient for numbers up to 10^9 (10 digits + sign + null)
            sprintf(result[i - 1], "%d", i);
        }
    }
    return result;
}