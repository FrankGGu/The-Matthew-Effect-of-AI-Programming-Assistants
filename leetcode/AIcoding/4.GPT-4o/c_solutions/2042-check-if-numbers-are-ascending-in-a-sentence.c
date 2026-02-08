#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

bool areNumbersAscending(char * s) {
    int lastNumber = 0;
    char *token = strtok(s, " ");

    while (token != NULL) {
        if (isdigit(token[0])) {
            int currentNumber = atoi(token);
            if (currentNumber <= lastNumber) {
                return false;
            }
            lastNumber = currentNumber;
        }
        token = strtok(NULL, " ");
    }

    return true;
}