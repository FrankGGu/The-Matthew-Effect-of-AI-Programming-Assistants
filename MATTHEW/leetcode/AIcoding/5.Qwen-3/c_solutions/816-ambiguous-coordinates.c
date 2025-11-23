#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **generateCoordinates(char *s, int *returnSize) {
    int n = strlen(s);
    char **result = NULL;
    *returnSize = 0;

    for (int i = 1; i < n; i++) {
        char *xStr = malloc(i + 1);
        strncpy(xStr, s, i);
        xStr[i] = '\0';

        char *yStr = malloc(n - i + 1);
        strncpy(yStr, s + i, n - i);
        yStr[n - i] = '\0';

        int xValid = 1;
        if (strlen(xStr) > 1 && xStr[0] == '0') xValid = 0;
        int yValid = 1;
        if (strlen(yStr) > 1 && yStr[0] == '0') yValid = 0;

        if (!xValid || !yValid) {
            free(xStr);
            free(yStr);
            continue;
        }

        int xLen = strlen(xStr);
        int yLen = strlen(yStr);

        char *x = malloc(xLen + 2);
        char *y = malloc(yLen + 2);

        strcpy(x, xStr);
        strcpy(y, yStr);

        int xHasDot = 0;
        if (xLen > 1) {
            sprintf(x, "%s.%s", xStr, xStr + 1);
            xHasDot = 1;
        }

        int yHasDot = 0;
        if (yLen > 1) {
            sprintf(y, "%s.%s", yStr, yStr + 1);
            yHasDot = 1;
        }

        if (xHasDot && yHasDot) {
            result = realloc(result, (*returnSize + 1) * sizeof(char *));
            result[*returnSize] = malloc(strlen(x) + strlen(y) + 3);
            sprintf(result[*returnSize], "(%s, %s)", x, y);
            (*returnSize)++;
        } else if (xHasDot) {
            result = realloc(result, (*returnSize + 1) * sizeof(char *));
            result[*returnSize] = malloc(strlen(x) + strlen(y) + 3);
            sprintf(result[*returnSize], "(%s, %s)", x, y);
            (*returnSize)++;
        } else if (yHasDot) {
            result = realloc(result, (*returnSize + 1) * sizeof(char *));
            result[*returnSize] = malloc(strlen(x) + strlen(y) + 3);
            sprintf(result[*returnSize], "(%s, %s)", x, y);
            (*returnSize)++;
        } else {
            result = realloc(result, (*returnSize + 1) * sizeof(char *));
            result[*returnSize] = malloc(strlen(x) + strlen(y) + 3);
            sprintf(result[*returnSize], "(%s, %s)", x, y);
            (*returnSize)++;
        }

        free(xStr);
        free(yStr);
        free(x);
        free(y);
    }

    return result;
}

char **ambiguousCoordinates(char *s, int *returnSize) {
    return generateCoordinates(s, returnSize);
}