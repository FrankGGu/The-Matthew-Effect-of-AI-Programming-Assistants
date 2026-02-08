#include <stdlib.h> // Required for calloc if used, though not strictly necessary for this problem with a fixed-size array

int findXOR(int* nums, int numsSize) {
    int freq[101] = {0}; // Constraints: 1 <= nums[i] <= 100
    int xorSum = 0;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    for (int i = 1; i <= 100; i++) {
        if (freq[i] == 2) {
            xorSum ^= i;
        }
    }

    return xorSum;
}