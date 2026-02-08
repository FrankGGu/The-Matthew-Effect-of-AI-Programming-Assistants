#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumFourDivisors(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int count = 0;
        int divisorSum = 0;
        for (int j = 1; j * j <= num; j++) {
            if (num % j == 0) {
                if (j * j == num) {
                    count++;
                    divisorSum += j;
                } else {
                    count += 2;
                    divisorSum += j + num / j;
                }
            }
            if (count > 4)
                break;
        }
        if (count == 4) {
            sum += divisorSum;
        }
    }
    return sum;
}