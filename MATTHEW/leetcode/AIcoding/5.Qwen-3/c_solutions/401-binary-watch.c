#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **readBinaryWatch(int num, int *returnSize) {
    char **result = (char **)malloc(1000 * sizeof(char *));
    int count = 0;

    for (int h = 0; h < 12; h++) {
        for (int m = 0; m < 60; m++) {
            int bits = __builtin_popcount(h) + __builtin_popcount(m);
            if (bits == num) {
                char *time = (char *)malloc(6 * sizeof(char));
                sprintf(time, "%d:%02d", h, m);
                result[count++] = time;
            }
        }
    }

    *returnSize = count;
    return result;
}