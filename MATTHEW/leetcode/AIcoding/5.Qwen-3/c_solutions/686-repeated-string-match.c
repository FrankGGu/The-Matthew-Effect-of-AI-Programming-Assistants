#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int repeatedStringMatch(char *a, char *b) {
    int lenA = strlen(a);
    int lenB = strlen(b);

    if (lenA == 0) return -1;

    int count = 0;
    char *result = (char *)malloc((lenA * 2 + 1) * sizeof(char));
    char *temp = result;

    while (temp - result < lenA * 2) {
        strcpy(temp, a);
        temp += lenA;
        count++;

        if (strstr(result, b)) {
            free(result);
            return count;
        }
    }

    free(result);
    return -1;
}