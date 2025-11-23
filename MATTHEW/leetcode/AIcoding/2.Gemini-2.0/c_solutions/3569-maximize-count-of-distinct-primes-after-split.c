#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distinctPrimeFactors(int n) {
    int count = 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            count++;
            while (n % i == 0) {
                n /= i;
            }
        }
    }
    if (n > 1) {
        count++;
    }
    return count;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maximizeGreatness(int* nums, int numsSize) {
    int ans = 0;
    int distinctPrimes1 = 0;
    int distinctPrimes2 = 0;
    for (int i = 0; i < numsSize; i++) {
        distinctPrimes1 += distinctPrimeFactors(nums[i]);
    }
    distinctPrimes2 = 0;
    for (int i = 0; i < numsSize; i++) {
        distinctPrimes2 += distinctPrimeFactors(nums[i]);
    }

    return distinctPrimes1;
}

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int* nums, int numsSize);

int distinctPrimeFactors(int n);

int max(int a, int b);

int distinctPrimeFactors(int n);

int maximizeGreatness(int nums[], int numsSize){
    int distinctPrimes[numsSize + 1];
    for (int i = 0; i <= numsSize; i++) {
        distinctPrimes[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int j = 2; j * j <= num; j++) {
            if (num % j == 0) {
                distinctPrimes[i]++;
                while (num % j == 0) {
                    num /= j;
                }
            }
        }
        if (num > 1) {
            distinctPrimes[i]++;
        }
    }

    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        result += distinctPrimes[i];
    }

    return result;
}