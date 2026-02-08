#include <stdio.h>
#include <stdlib.h>

int* numPairsDivisibleBy60(int* time, int timeSize, int* returnSize) {
    int* count = (int*)calloc(60, sizeof(int));
    int* result = (int*)malloc(sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < timeSize; i++) {
        int mod = time[i] % 60;
        if (mod == 0) {
            *result = *result + count[0];
        } else {
            *result = *result + count[60 - mod];
        }
        count[mod]++;
    }

    return result;
}