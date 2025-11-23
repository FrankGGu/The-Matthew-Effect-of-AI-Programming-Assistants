#include <limits.h>

int getMaxDigit(int n) {
    int maxD = 0;
    while (n > 0) {
        int digit = n % 10;
        if (digit > maxD) {
            maxD = digit;
        }
        n /= 10;
    }
    return maxD;
}

int maxPairSum(int* nums, int numsSize) {
    int largest[10];
    int secondLargest[10];

    for (int i = 0; i < 10; i++) {
        largest[i] = -1;
        secondLargest[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int maxD = getMaxDigit(num);

        if (num > largest[maxD]) {
            secondLargest[maxD] = largest[maxD];
            largest[maxD] = num;
        } else if (num > secondLargest[maxD]) {
            secondLargest[maxD] = num;
        }
    }

    int maxOverallSum = -1;

    for (int d = 0; d < 10; d++) {
        if (largest[d] != -1 && secondLargest[d] != -1) {
            int currentSum = largest[d] + secondLargest[d];
            if (currentSum > maxOverallSum) {
                maxOverallSum = currentSum;
            }
        }
    }

    return maxOverallSum;
}