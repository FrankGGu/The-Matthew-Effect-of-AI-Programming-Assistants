#include <stdio.h>
#include <stdlib.h>

#define MOD 1000000007

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

int countSubsequences(int* nums, int numsSize) {
    long long* pow2 = (long long*)malloc((numsSize + 1) * sizeof(long long));
    pow2[0] = 1;
    for (int i = 1; i <= numsSize; i++) {
        pow2[i] = (pow2[i - 1] * 2) % MOD;
    }

    long long result = 0;
    for (int g = 1; g <= 100000; g++) {
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] % g == 0) {
                count++;
            }
        }
        if (count > 0) {
            long long total = pow2[count] - 1;
            if (gcd(g, g) == g) {
                result = (result + total) % MOD;
            }
        }
    }

    free(pow2);
    return (int)result;
}