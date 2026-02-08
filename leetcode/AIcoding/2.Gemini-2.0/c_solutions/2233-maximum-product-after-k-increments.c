#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int maximumProduct(int* nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(int), cmp);

    int i = 0;
    while (k > 0) {
        if (i + 1 < numsSize && nums[i] + k >= nums[i+1]) {
            int diff = nums[i+1] - nums[i];
            if (k >= diff * (i + 1)) {
                k -= diff * (i + 1);
                for (int j = 0; j <= i; j++) {
                    nums[j] += diff;
                }
                i++;
            } else {
                int increment = k / (i + 1);
                for (int j = 0; j <= i; j++) {
                    nums[j] += increment;
                }
                k -= increment * (i + 1);
                for (int j = 0; j <= i && k > 0; j++) {
                    nums[j]++;
                    k--;
                }
            }
        } else {
            int increment = k / (i + 1);
            for (int j = 0; j <= i; j++) {
                nums[j] += increment;
            }
            k -= increment * (i + 1);
            for (int j = 0; j <= i && k > 0; j++) {
                nums[j]++;
                k--;
            }
        }
    }

    long long product = 1;
    long long mod = 1000000007;
    for (int j = 0; j < numsSize; j++) {
        product = (product * nums[j]) % mod;
    }

    return (int)product;
}