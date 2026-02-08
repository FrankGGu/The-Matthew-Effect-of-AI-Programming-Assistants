#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int waysToMakeFair(int* nums, int numsSize) {
    int evenSum = 0, oddSum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            evenSum += nums[i];
        } else {
            oddSum += nums[i];
        }
    }

    int count = 0;
    int currEvenSum = 0, currOddSum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            if (currEvenSum + (oddSum - currOddSum) == currOddSum + (evenSum - currEvenSum - nums[i])) {
                count++;
            }
            currEvenSum += nums[i];
        } else {
            if (currEvenSum + (oddSum - currOddSum - nums[i]) == currOddSum + (evenSum - currEvenSum)) {
                count++;
            }
            currOddSum += nums[i];
        }
    }

    return count;
}