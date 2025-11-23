#include <stdio.h>
#include <stdlib.h>

void backtrack(int num, int start, int *result, int *returnSize, char **res) {
    if (num == 0) {
        char time[6];
        sprintf(time, "%d:%02d", result[0], result[1]);
        res[(*returnSize)++] = strdup(time);
        return;
    }
    for (int i = start; i < 10; i++) {
        if (i < 4) {
            result[0] += (1 << i);
        } else {
            result[1] += (1 << (i - 4));
        }
        backtrack(num - 1, i + 1, result, returnSize, res);
        if (i < 4) {
            result[0] -= (1 << i);
        } else {
            result[1] -= (1 << (i - 4));
        }
    }
}

char **readBinaryWatch(int turnedOn, int *returnSize) {
    char **res = (char **)malloc(512 * sizeof(char *));
    int result[2] = {0, 0};
    *returnSize = 0;
    backtrack(turnedOn, 0, result, returnSize, res);
    return res;
}