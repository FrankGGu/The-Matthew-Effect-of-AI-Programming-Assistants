#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int countSquareFreeSubsets(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }

    int* squareFree = (int*)calloc(maxNum + 1, sizeof(int));
    for (int i = 2; i * i <= maxNum; i++) {
        for (int j = i * i; j <= maxNum; j += i * i) {
            squareFree[j] = 1;
        }
    }

    int dp[1 << 10] = {0};
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (squareFree[num]) continue;

        int mask = 0;
        for (int j = 2; j * j <= num; j++) {
            if (num % j == 0) {
                int cnt = 0;
                while (num % j == 0) {
                    num /= j;
                    cnt++;
                }
                if (cnt >= 2) {
                    mask = -1;
                    break;
                }
                mask |= 1 << (j - 2);
            }
        }
        if (mask == -1) continue;

        if (num > 1) mask |= 1 << (num - 2);

        for (int j = (1 << 10) - 1; j >= 0; j--) {
            if ((j & mask) == 0) {
                dp[j | mask] = (dp[j | mask] + dp[j]) % 1000000007;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < (1 << 10); i++) {
        result = (result + dp[i]) % 1000000007;
    }

    return result;
}