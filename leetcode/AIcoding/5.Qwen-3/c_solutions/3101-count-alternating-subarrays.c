#include <stdio.h>
#include <stdlib.h>

int countAlternatingSubarrays(int* nums, int numsSize) {
    int count = 0;
    int n = numsSize;
    for (int i = 0; i < n; i++) {
        int j = i;
        while (j + 1 < n && nums[j] != nums[j + 1]) {
            j++;
        }
        int length = j - i + 1;
        count += (length * (length + 1)) / 2;
        i = j;
    }
    return count;
}