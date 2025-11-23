#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* nameSequence(int n) {
    char* result = (char*)malloc((n * 10 + 1) * sizeof(char));
    int index = 0;
    for (int i = 1; i <= n; i++) {
        if (i % 3 == 0 && i % 5 == 0) {
            sprintf(result + index, "FizzBuzz");
            index += 8;
        } else if (i % 3 == 0) {
            sprintf(result + index, "Fizz");
            index += 4;
        } else if (i % 5 == 0) {
            sprintf(result + index, "Buzz");
            index += 4;
        } else {
            sprintf(result + index, "%d", i);
            index += snprintf(NULL, 0, "%d", i);
        }
        if (i != n) {
            result[index++] = ' ';
        }
    }
    result[index] = '\0';
    return result;
}