#include <stdbool.h>

int sumCounts(int* nums, int numsSize) {
    long long totalSum = 0;

    for (int i = 0; i < numsSize; i++) {
        bool seen[101] = {false};
        int distinctCount = 0;

        for (int j = i; j < numsSize; j++) {
            int currentNum = nums[j];

            if (!seen[currentNum]) {
                seen[currentNum] = true;
                distinctCount++;
            }
            totalSum += (long long)distinctCount * distinctCount;
        }
    }

    return (int)totalSum;
}