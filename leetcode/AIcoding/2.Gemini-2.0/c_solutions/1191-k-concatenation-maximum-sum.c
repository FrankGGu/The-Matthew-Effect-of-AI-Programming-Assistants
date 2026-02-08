#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int kConcatenationMaxSum(int* arr, int arrSize, int k) {
    long long maxSubarraySum(int* arr, int arrSize) {
        long long maxSoFar = 0;
        long long currentMax = 0;
        for (int i = 0; i < arrSize; i++) {
            currentMax = currentMax + arr[i];
            if (currentMax < 0) {
                currentMax = 0;
            }
            if (maxSoFar < currentMax) {
                maxSoFar = currentMax;
            }
        }
        if (maxSoFar == 0) {
            maxSoFar = arr[0];
            for(int i=1; i< arrSize; i++){
                if(arr[i] > maxSoFar)
                    maxSoFar = arr[i];
            }
        }
        return maxSoFar;
    }

    long long totalSum = 0;
    for (int i = 0; i < arrSize; i++) {
        totalSum += arr[i];
    }

    long long maxSub = maxSubarraySum(arr, arrSize);

    if (k == 1) {
        return maxSub % MOD;
    }

    long long maxPrefixSum = 0;
    long long currentPrefixSum = 0;
    for (int i = 0; i < arrSize; i++) {
        currentPrefixSum += arr[i];
        if (currentPrefixSum > maxPrefixSum) {
            maxPrefixSum = currentPrefixSum;
        }
    }

    long long maxSuffixSum = 0;
    long long currentSuffixSum = 0;
    for (int i = arrSize - 1; i >= 0; i--) {
        currentSuffixSum += arr[i];
        if (currentSuffixSum > maxSuffixSum) {
            maxSuffixSum = currentSuffixSum;
        }
    }

    long long result;
    if (totalSum > 0) {
        result = maxSub > (maxPrefixSum + maxSuffixSum + (k - 2) * totalSum) ? maxSub : (maxPrefixSum + maxSuffixSum + (k - 2) * totalSum);
    } else {
        result = maxSub > (maxPrefixSum + maxSuffixSum) ? maxSub : (maxPrefixSum + maxSuffixSum);
    }

    return result % MOD;
}