#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* cellsInRange(char* s) {
    char* result = (char*)malloc(1000 * sizeof(char));
    int index = 0;

    char start_col = s[0];
    char end_col = s[3];
    int start_row = s[1] - '0';
    int end_row = s[4] - '0';

    for (char c = start_col; c <= end_col; c++) {
        for (int r = start_row; r <= end_row; r++) {
            result[index++] = c;
            result[index++] = r + '0';
            result[index++] = ',';
        }
    }

    result[index - 1] = '\0';
    return result;
}