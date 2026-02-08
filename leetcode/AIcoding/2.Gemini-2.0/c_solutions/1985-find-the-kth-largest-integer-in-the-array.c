#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    const char *str_a = *(const char **)a;
    const char *str_b = *(const char **)b;

    int len_a = strlen(str_a);
    int len_b = strlen(str_b);

    if (len_a != len_b) {
        return len_a - len_b;
    } else {
        return strcmp(str_a, str_b);
    }
}

char * kthLargestNumber(char ** nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(char *), compare);
    return nums[numsSize - k];
}