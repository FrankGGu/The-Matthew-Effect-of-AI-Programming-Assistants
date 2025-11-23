#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* goodDaysToRobBank(int* security, int securitySize, int time, int* returnSize){
    if (securitySize < 2 * time + 1) {
        *returnSize = 0;
        return NULL;
    }

    int* non_increasing_left = (int*)malloc(securitySize * sizeof(int));
    int* non_decreasing_right = (int*)malloc(securitySize * sizeof(int));

    non_increasing_left[0] = 0;
    for (int i = 1; i < securitySize; ++i) {
        if (security[i] <= security[i - 1]) {
            non_increasing_left[i] = non_increasing_left[i - 1] + 1;
        } else {
            non_increasing_left[i] = 0;
        }
    }

    non_decreasing_right[securitySize - 1] = 0;
    for (int i = securitySize - 2; i >= 0; --i) {
        if (security[i] <= security[i + 1]) {
            non_decreasing_right[i] = non_decreasing_right[i + 1] + 1;
        } else {
            non_decreasing_right[i] = 0;
        }
    }

    int* result = (int*)malloc(securitySize * sizeof(int));
    int count = 0;
    for (int i = time; i < securitySize - time; ++i) {
        if (non_increasing_left[i] >= time && non_decreasing_right[i] >= time) {
            result[count++] = i;
        }
    }

    free(non_increasing_left);
    free(non_decreasing_right);

    *returnSize = count;
    return result;
}