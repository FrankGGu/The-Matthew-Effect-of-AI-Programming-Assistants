#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maxStrength(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int negCount = 0;
    int posCount = 0;
    int zeroCount = 0;
    long long maxNeg = -10;
    long long product = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0) {
            negCount++;
            if (nums[i] > maxNeg) {
                maxNeg = nums[i];
            }
        } else if (nums[i] > 0) {
            posCount++;
        } else {
            zeroCount++;
        }
    }

    if (posCount == 0 && negCount == 0) {
        return 0;
    }

    if (posCount == 0 && negCount == 1 && zeroCount > 0) {
        return 0;
    }

    if (posCount == 0 && negCount == 1) {
        return maxNeg;
    }

    if (posCount == 0 && negCount % 2 != 0 && zeroCount > 0) {
        return 0;
    }

    if (posCount == 0 && negCount == 0 && zeroCount > 0)
    {
        return 0;
    }

    if (posCount == 0 && negCount % 2 != 0)
    {
        if (negCount == 1 && zeroCount > 0) return 0;
        if (negCount == 1 && zeroCount == 0) return maxNeg;
        for (int i = 0; i < numsSize; i++)
        {
            if (nums[i] == maxNeg)
            {
                nums[i] = 1;
                break;
            }
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != 0) {
            product *= nums[i];
        }
    }

    return product;
}