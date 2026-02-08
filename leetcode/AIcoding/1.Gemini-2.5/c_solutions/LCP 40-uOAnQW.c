#include <stdlib.h>

int sumDigits(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maxmiumScore(int* nums, int numsSize, int target) {
    int* evenDigitSumNums = (int*)malloc(sizeof(int) * numsSize);
    int evenDigitSumCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (sumDigits(nums[i]) % 2 == 0) {
            evenDigitSumNums[evenDigitSumCount++] = nums[i];
        }
    }

    qsort(evenDigitSumNums, evenDigitSumCount, sizeof(int), compare);

    int currentScore = 0;
    for (int i = 0; i < evenDigitSumCount; i++) {
        if (currentScore + evenDigitSumNums[i] <= target) {
            currentScore += evenDigitSumNums[i];
        } else {
            break;
        }
    }

    free(evenDigitSumNums);

    return currentScore;
}