#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **cellsInRange(char *s, int *returnSize) {
    char start_col = s[0];
    int start_row = s[1] - '0';
    char end_col = s[3];
    int end_row = s[4] - '0';

    *returnSize = (end_col - start_col + 1) * (end_row - start_row + 1);
    char **result = (char **)malloc(*returnSize * sizeof(char *));

    int index = 0;
    for (char col = start_col; col <= end_col; col++) {
        for (int row = start_row; row <= end_row; row++) {
            result[index] = (char *)malloc(3 * sizeof(char));
            result[index][0] = col;
            result[index][1] = row + '0';
            result[index][2] = '\0';
            index++;
        }
    }

    return result;
}