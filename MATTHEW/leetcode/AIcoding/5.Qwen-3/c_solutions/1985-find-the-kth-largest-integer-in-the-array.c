#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    const char *strA = *(const char**)a;
    const char *strB = *(const char**)b;
    int lenA = strlen(strA);
    int lenB = strlen(strB);

    if (lenA != lenB) {
        return lenB - lenA;
    }
    return strcmp(strA, strB);
}

char* kthLargestNumber(char** nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(char*), compare);
    return nums[numsSize - k];
}