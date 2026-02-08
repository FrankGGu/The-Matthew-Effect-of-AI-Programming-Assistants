#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNonDecreasingLength(int* nums, int numsSize) {
    int* dp = (int*)malloc(sizeof(int) * numsSize);
    int* sum = (int*)malloc(sizeof(int) * numsSize);
    int* last = (int*)malloc(sizeof(int) * numsSize);
    int len = 0;

    for (int i = 0; i < numsSize; i++) {
        sum[i] = nums[i];
        if (i > 0) {
            sum[i] += sum[i - 1];
        }

        int l = 0, r = len;
        while (l < r) {
            int mid = (l + r) / 2;
            if (sum[last[mid]] <= nums[i]) {
                r = mid;
            } else {
                l = mid + 1;
            }
        }

        if (l == 0) {
            dp[i] = 1;
        } else {
            dp[i] = dp[last[l - 1]] + 1;
        }

        while (len > 0 && dp[last[len - 1]] >= dp[i]) {
            len--;
        }

        last[len++] = i;

        if (l < len - 1 && sum[last[l + 1]] - (l == 0 ? 0 : sum[last[l - 1]]) <= nums[i]) {
            len--;
        }
    }

    int ans = 0;
    for (int i = 0; i < numsSize; i++) {
        if (ans < dp[i]) {
            ans = dp[i];
        }
    }

    free(dp);
    free(sum);
    free(last);
    return ans;
}