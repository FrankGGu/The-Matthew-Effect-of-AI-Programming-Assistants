#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countSetBits(long long n) {
    long long count = 0;
    long long powerOfTwo = 1;
    while (powerOfTwo <= n) {
        long long cycleLen = powerOfTwo * 2;
        long long fullCycles = n / cycleLen;
        count += fullCycles * powerOfTwo;
        long long remainder = n % cycleLen;
        if (remainder >= powerOfTwo) {
            count += (remainder - powerOfTwo + 1);
        }
        powerOfTwo *= 2;
    }
    return count;
}

long long findMaximumNumber(long long k) {
    long long low = 0, high = k + 100; 
    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (countSetBits(mid) <= k) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}