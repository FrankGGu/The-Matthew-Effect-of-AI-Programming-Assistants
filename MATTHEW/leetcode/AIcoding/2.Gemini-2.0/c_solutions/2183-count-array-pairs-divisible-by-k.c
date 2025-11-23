#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

long long countPairs(int* nums, int numsSize, int k) {
    int count[100001] = {0};
    long long ans = 0;

    for (int i = 0; i < numsSize; i++) {
        int g = gcd(nums[i], k);
        for (int j = 1; j * j <= k; j++) {
            if (k % j == 0) {
                if (g % j == 0) {
                    ans += count[k / j];
                }
                if (j * j != k && g % (k / j) == 0) {
                    ans += count[j];
                }
            }
        }
        count[g]++;
    }

    return ans;
}