#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    char *num1 = *(char **)a;
    char *num2 = *(char **)b;
    char result1[30], result2[30];
    strcpy(result1, num1);
    strcat(result1, num2);
    strcpy(result2, num2);
    strcat(result2, num1);
    return strcmp(result2, result1);
}

char *largestNumber(int* nums, int numsSize) {
    if (numsSize == 0) return "";

    char **strs = (char **)malloc(numsSize * sizeof(char *));
    for (int i = 0; i < numsSize; i++) {
        strs[i] = (char *)malloc(12 * sizeof(char));
        sprintf(strs[i], "%d", nums[i]);
    }

    qsort(strs, numsSize, sizeof(char *), cmp);

    if (strcmp(strs[0], "0") == 0) {
        free(strs);
        return "0";
    }

    char *result = (char *)malloc(12 * numsSize * sizeof(char));
    result[0] = '\0';

    for (int i = 0; i < numsSize; i++) {
        strcat(result, strs[i]);
        free(strs[i]);
    }
    free(strs);

    return result;
}