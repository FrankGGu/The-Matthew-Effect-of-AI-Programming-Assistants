#include <limits.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int minOperations(int* nums, int numsSize) {
    int count_ones = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            count_ones++;
        }
    }

    if (count_ones > 0) {
        return numsSize - count_ones;
    }

    int min_len_to_one = INT_MAX;

    for (int i = 0; i < numsSize; i++) {
        int current_gcd = nums[i];
        for (int j = i + 1; j < numsSize; j++) {
            current_gcd = gcd(current_gcd, nums[j]);
            if (current_gcd == 1) {
                if (j - i + 1 < min_len_to_one) {
                    min_len_to_one = j - i + 1;
                }
                break;
            }
        }
    }

    if (min_len_to_one == INT_MAX) {
        return -1;
    }

    return (min_len_to_one - 1) + (numsSize - 1);
}