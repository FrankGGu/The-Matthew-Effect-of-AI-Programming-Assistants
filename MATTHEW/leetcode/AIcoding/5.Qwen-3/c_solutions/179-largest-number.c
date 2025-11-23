#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char *x = *(char**)a;
    char *y = *(char**)b;
    char xy[20], yx[20];
    strcpy(xy, x);
    strcat(xy, y);
    strcpy(yx, y);
    strcat(yx, x);
    return strcmp(yx, xy);
}

char* largestNumber(int* nums, int numsSize) {
    if (numsSize == 0) return strdup("0");
    char** strNums = (char**)malloc(numsSize * sizeof(char*));
    for (int i = 0; i < numsSize; i++) {
        strNums[i] = (char*)malloc(20 * sizeof(char));
        sprintf(strNums[i], "%d", nums[i]);
    }
    qsort(strNums, numsSize, sizeof(char*), compare);
    char* result = (char*)malloc(20 * numsSize * sizeof(char));
    int index = 0;
    for (int i = 0; i < numsSize; i++) {
        if (strcmp(strNums[0], "0") == 0) {
            free(result);
            return strdup("0");
        }
        index += sprintf(result + index, "%s", strNums[i]);
    }
    for (int i = 0; i < numsSize; i++) {
        free(strNums[i]);
    }
    free(strNums);
    return result;
}