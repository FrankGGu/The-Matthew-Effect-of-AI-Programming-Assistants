#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char *x = *(char **)a;
    char *y = *(char **)b;
    return strcmp(y, x);
}

long long maxBinaryNumber(char ** nums, int numsSize) {
    qsort(nums, numsSize, sizeof(char *), compare);
    char *result = (char *)malloc(1000 * sizeof(char));
    result[0] = '\0';
    for (int i = 0; i < numsSize; i++) {
        strcat(result, nums[i]);
    }
    long long num = 0;
    for (int i = 0; i < strlen(result); i++) {
        num = num * 2 + (result[i] - '0');
    }
    free(result);
    return num;
}