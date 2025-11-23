#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rob(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    int include = nums[0];
    int exclude = 0;

    for (int i = 1; i < numsSize; i++) {
        int new_include = exclude + nums[i];
        int new_exclude = (include > exclude) ? include : exclude;

        include = new_include;
        exclude = new_exclude;
    }

    return (include > exclude) ? include : exclude;
}