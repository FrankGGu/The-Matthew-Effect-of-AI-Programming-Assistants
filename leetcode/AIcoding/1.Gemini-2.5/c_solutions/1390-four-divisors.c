#include <stdbool.h> // Not strictly needed, but good for boolean types if used

long long sumFourDivisors(int* nums, int numsSize) {
    long long totalSum = 0;

    for (int k = 0; k < numsSize; ++k) {
        int num = nums[k];
        long long currentDivisorSum = 0;
        int divisorCount = 0;

        for (int i = 1; i * i <= num; ++i) {
            if (num % i == 0) {
                if (i * i == num) {
                    divisorCount++;
                    currentDivisorSum += i;
                } else {
                    divisorCount += 2;
                    currentDivisorSum += i;
                    currentDivisorSum += (num / i);
                }
            }
            if (divisorCount > 4) {
                break;
            }
        }

        if (divisorCount == 4) {
            totalSum += currentDivisorSum;
        }
    }

    return totalSum;
}