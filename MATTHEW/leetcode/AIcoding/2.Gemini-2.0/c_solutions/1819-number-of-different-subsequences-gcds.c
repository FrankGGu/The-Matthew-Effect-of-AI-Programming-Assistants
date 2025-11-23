#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int countDifferentSubsequenceGCDs(int* nums, int numsSize) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    bool present[maxVal + 1];
    for (int i = 0; i <= maxVal; i++) {
        present[i] = false;
    }
    for (int i = 0; i < numsSize; i++) {
        present[nums[i]] = true;
    }

    int count = 0;
    for (int i = 1; i <= maxVal; i++) {
        int currentGCD = 0;
        for (int j = i; j <= maxVal; j += i) {
            if (present[j]) {
                if (currentGCD == 0) {
                    currentGCD = j;
                } else {
                    currentGCD = gcd(currentGCD, j);
                }
            }
        }
        if (currentGCD == i) {
            count++;
        }
    }

    return count;
}