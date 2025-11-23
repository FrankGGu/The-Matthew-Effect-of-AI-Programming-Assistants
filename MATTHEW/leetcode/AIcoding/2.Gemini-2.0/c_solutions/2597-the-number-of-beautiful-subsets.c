#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int beautifulSubsets(int* nums, int numsSize, int k) {
    int dp[1001] = {0};
    dp[0] = 1;
    int ans = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int temp[1001];
        for(int j = 0; j < 1001; j++){
            temp[j] = dp[j];
        }

        for (int j = 1; j <= 1000; j++) {
            if (j == num + k || j == num - k) continue;
            if(num > 1000) continue;
            dp[num] += temp[j];
        }

        dp[num]++;
        ans += dp[num] - 1;
    }
    return ans;
}