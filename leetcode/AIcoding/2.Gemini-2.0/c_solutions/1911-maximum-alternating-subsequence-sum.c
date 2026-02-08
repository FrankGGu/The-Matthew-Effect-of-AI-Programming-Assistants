#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxAlternatingSum(int* nums, int numsSize) {
    int even = nums[0];
    int odd = 0;

    for (int i = 1; i < numsSize; i++) {
        int newEven = (even > odd + nums[i]) ? even : odd + nums[i];
        int newOdd = (odd > even - nums[i]) ? odd : even - nums[i];
        even = newEven;
        odd = newOdd;
    }

    return even;
}