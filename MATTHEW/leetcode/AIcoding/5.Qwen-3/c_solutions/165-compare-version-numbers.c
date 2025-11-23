#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compareVersionNumbers(char *version1, char *version2) {
    int num1, num2;
    char *token1 = strtok(version1, ".");
    char *token2 = strtok(version2, ".");

    while (token1 || token2) {
        num1 = token1 ? atoi(token1) : 0;
        num2 = token2 ? atoi(token2) : 0;

        if (num1 < num2) return -1;
        if (num1 > num2) return 1;

        token1 = strtok(NULL, ".");
        token2 = strtok(NULL, ".");
    }

    return 0;
}