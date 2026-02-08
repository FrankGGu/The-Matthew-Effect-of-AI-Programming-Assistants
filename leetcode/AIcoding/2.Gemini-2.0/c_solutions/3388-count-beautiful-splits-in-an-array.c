#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countBeautifulPairs(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int firstDigit = 0;
            int temp = nums[i];
            while (temp > 0) {
                firstDigit = temp;
                temp /= 10;
            }
            if (gcd(firstDigit, nums[j] % 10) == 1) {
                count++;
            }
        }
    }
    return count;
}

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}