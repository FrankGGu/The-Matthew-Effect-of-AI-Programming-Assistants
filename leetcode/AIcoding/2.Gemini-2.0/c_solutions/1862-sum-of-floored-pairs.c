#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfFlooredPairs(int* nums, int numsSize){
    long long mod = 1e9 + 7;
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    long long counts[maxVal + 1];
    for (int i = 0; i <= maxVal; i++) {
        counts[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        counts[nums[i]]++;
    }

    for (int i = 1; i <= maxVal; i++) {
        counts[i] += counts[i - 1];
    }

    long long ans = 0;
    for (int i = 1; i <= maxVal; i++) {
        long long freq = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] == i) {
                freq++;
            }
        }
        if (freq == 0) continue;

        for (int k = 1; k * i <= maxVal; k++) {
            long long upper = k * i + i - 1;
            if (upper > maxVal) upper = maxVal;
            long long count = counts[upper] - counts[k * i - 1];
            ans = (ans + freq * count) % mod;
        }
    }

    return (int)ans;
}