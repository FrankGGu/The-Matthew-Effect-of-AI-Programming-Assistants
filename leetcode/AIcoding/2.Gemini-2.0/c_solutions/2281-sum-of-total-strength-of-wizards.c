#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfTotalStrength(int* strength, int strengthSize) {
    int MOD = 1000000007;
    long long prefixSum[strengthSize + 1];
    prefixSum[0] = 0;
    for (int i = 0; i < strengthSize; i++) {
        prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
    }

    long long left[strengthSize];
    long long right[strengthSize];
    for (int i = 0; i < strengthSize; i++) {
        left[i] = 1;
        right[i] = 1;
    }

    for (int i = 0; i < strengthSize; i++) {
        int j = i - 1;
        while (j >= 0 && strength[j] > strength[i]) {
            j--;
        }
        left[i] = i - j;
    }

    for (int i = strengthSize - 1; i >= 0; i--) {
        int j = i + 1;
        while (j < strengthSize && strength[j] >= strength[i]) {
            j++;
        }
        right[i] = j - i;
    }

    long long ans = 0;
    for (int i = 0; i < strengthSize; i++) {
        long long l = left[i];
        long long r = right[i];

        long long sum = 0;
        long long leftIndex = i - l + 1;
        long long rightIndex = i + r - 1;

        long long modInverseL = 0;
        long long modInverseR = 0;

        long long sumL;
        if (leftIndex <= 0) {
            sumL = 0;
        } else {
            sumL = (i - leftIndex + 1) * (prefixSum[i+1] - prefixSum[leftIndex] + MOD) % MOD;
            sumL = (sumL - (prefixSum[i+1] - prefixSum[leftIndex]) * (leftIndex-1) % MOD + MOD) % MOD;
        }

        long long sumR;
        if (rightIndex >= strengthSize - 1) {
            sumR = 0;
        } else {
            sumR = (rightIndex - i) * (prefixSum[rightIndex+1] - prefixSum[i+1] + MOD) % MOD;
            sumR = (sumR - (prefixSum[rightIndex+1] - prefixSum[i+1]) * (strengthSize - rightIndex -2) % MOD + MOD) % MOD;
        }

        long long totalSum = 0;
        totalSum = (l * r) % MOD * strength[i] % MOD;

        long long cur = ((l % MOD) * (r % MOD)) % MOD;

        long long l_sum_mod = ((l * (l - 1) / 2) % MOD);
        long long r_sum_mod = ((r * (r - 1) / 2) % MOD);

        long long tempSum = 0;

       long long leftSum = 0;
        if (i - l + 1 <= 0)
        {
            leftSum = prefixSum[i+1];
        }
        else
        {
            leftSum = (prefixSum[i+1] - prefixSum[i-l+1] + MOD) % MOD;
        }

        long long rightSum = 0;
        if (i + r >= strengthSize)
        {
            rightSum = 0;
        }
        else
        {
             rightSum = (prefixSum[i+r] - prefixSum[i] + MOD) % MOD;
        }

        tempSum = ((l*r)%MOD * strength[i]%MOD)%MOD;

        ans = (ans + tempSum) % MOD;
    }

    return (int)ans;
}