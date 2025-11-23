#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumOperations(int* nums, int numsSize) {
    int dp[numsSize][numsSize];

    int solve(int i, int j) {
        if (i >= j) {
            return 0;
        }

        if (dp[i][j] != -1) {
            return dp[i][j];
        }

        int count = 0;
        if (i + 1 < numsSize && nums[i] + nums[i + 1] == nums[i][j]) {
            count = fmax(count, 1 + solve(i + 2, j));
        }
        if (j - 1 >= 0 && nums[j] + nums[j - 1] == nums[i][j]) {
            count = fmax(count, 1 + solve(i, j - 2));
        }
        if (i < j && nums[i] + nums[j] == nums[i][j]) {
            count = fmax(count, 1 + solve(i + 1, j - 1));
        }

        return dp[i][j] = count;
    }

    int ans = 0;

    for (int k = 0; k < 3; ++k) {
        for(int i = 0; i < numsSize; i++) {
            for(int j = 0; j < numsSize; j++) {
                dp[i][j] = -1;
            }
        }

        int target;
        if (k == 0) {
            if (numsSize < 2) continue;
            target = nums[0] + nums[1];
        } else if (k == 1) {
             if (numsSize < 2) continue;
            target = nums[numsSize - 1] + nums[numsSize - 2];
        } else {
            if (numsSize < 2) continue;
            target = nums[0] + nums[numsSize - 1];
        }

        for(int i = 0; i < numsSize; i++) {
            for(int j = 0; j < numsSize; j++) {
                dp[i][j] = -1;
            }
        }

        int solve_with_target(int i, int j, int target) {
            if (i >= j) {
                return 0;
            }

            if (dp[i][j] != -1) {
                return dp[i][j];
            }

            int count = 0;
            if (i + 1 < numsSize && nums[i] + nums[i + 1] == target) {
                count = fmax(count, 1 + solve_with_target(i + 2, j, target));
            }
            if (j - 1 >= 0 && nums[j] + nums[j - 1] == target) {
                count = fmax(count, 1 + solve_with_target(i, j - 2, target));
            }
            if (i < j && nums[i] + nums[j] == target) {
                count = fmax(count, 1 + solve_with_target(i + 1, j - 1, target));
            }

            return dp[i][j] = count;
        }

        ans = fmax(ans, solve_with_target(0, numsSize - 1, target));
    }

    return ans;
}