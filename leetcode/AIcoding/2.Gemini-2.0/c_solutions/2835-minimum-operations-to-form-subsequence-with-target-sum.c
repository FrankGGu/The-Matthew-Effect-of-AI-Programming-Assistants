#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int target) {
    int sum = 0;
    int count[32] = {0};
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        int bit = 0;
        int temp = nums[i];
        while (temp > 0) {
            temp >>= 1;
            bit++;
        }
        count[bit - 1]++;
    }

    if (sum < target) {
        return -1;
    }

    int ans = 0;
    for (int i = 0; i < 31; i++) {
        if ((target >> i) & 1) {
            if (count[i] > 0) {
                count[i]--;
            } else {
                int j = i + 1;
                while (j < 31 && count[j] == 0) {
                    j++;
                }
                if (j == 31) {
                    return -1;
                }
                count[j]--;
                ans += (j - i);
                for (int k = i; k < j; k++) {
                    count[k]++;
                }
            }
        }
        count[i + 1] += count[i] / 2;
    }

    return ans;
}