#include <stdlib.h>
#include <string.h>

long long minOperations(int* nums, int numsSize, int target) {
    long long ops = 0;
    long long available_bits[31] = {0}; 

    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        int p = 0;
        while ((1LL << (p + 1)) <= num) {
            p++;
        }
        available_bits[p]++;
    }

    for (int i = 0; i <= 30; ++i) {
        if ((target >> i) & 1) {
            if (available_bits[i] > 0) {
                available_bits[i]--;
            } else {
                int j = i + 1;
                while (j <= 30 && available_bits[j] == 0) {
                    j++;
                }

                if (j > 30) {
                    return -1;
                }

                available_bits[j]--;
                ops += (j - i);

                available_bits[i] += (1LL << (j - i)) - 1;
            }
        }

        if (i + 1 <= 30) {
            available_bits[i+1] += available_bits[i] / 2;
        }
    }

    return ops;
}