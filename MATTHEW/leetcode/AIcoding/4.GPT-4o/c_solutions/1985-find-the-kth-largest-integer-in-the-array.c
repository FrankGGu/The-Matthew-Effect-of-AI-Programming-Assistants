#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char * kthLargestNumber(char ** nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(char *), compare);
    return nums[numsSize - k];
}