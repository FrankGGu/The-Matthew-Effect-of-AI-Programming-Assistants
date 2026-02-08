#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int primeFactors(int n) {
    int count = 0;
    if (n % 2 == 0) {
        count++;
        while (n % 2 == 0)
            n = n / 2;
    }
    for (int i = 3; i * i <= n; i = i + 2) {
        if (n % i == 0) {
            count++;
            while (n % i == 0)
                n = n / i;
        }
    }
    if (n > 2)
        count++;
    return count;
}

int cmp(const void *a, const void *b) {
    return ((int*)b)[0] - ((int*)a)[0];
}

int maximizeScore(int* nums, int numsSize, int k){
    int arr[numsSize][2];
    for (int i = 0; i < numsSize; i++) {
        arr[i][0] = primeFactors(nums[i]);
        arr[i][1] = i;
    }

    qsort(arr, numsSize, sizeof(arr[0]), cmp);

    long long ans = 1;
    for (int i = 0; i < k; i++) {
        ans = (ans * nums[arr[i][1]]) % MOD;
    }

    return (int)ans;
}