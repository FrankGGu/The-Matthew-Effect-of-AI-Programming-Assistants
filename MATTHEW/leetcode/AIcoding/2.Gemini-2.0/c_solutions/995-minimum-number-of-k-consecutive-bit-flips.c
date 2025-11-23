#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minKBitFlips(int* nums, int numsSize, int k) {
    int flips = 0;
    int flipped[numsSize];
    for (int i = 0; i < numsSize; i++) {
        flipped[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] + flipped[i]) % 2 == 0) {
            if (i + k > numsSize) {
                return -1;
            }
            flips++;
            for (int j = i; j < i + k; j++) {
                if (j + 1 < numsSize)
                    flipped[j + 1] = (flipped[j + 1] + 1) % 2;
            }
        }
    }

    return flips;
}