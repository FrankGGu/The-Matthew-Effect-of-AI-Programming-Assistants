#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int lastStoneWeightII(int* stones, int stonesSize) {
    int sum = 0;
    for (int i = 0; i < stonesSize; i++) {
        sum += stones[i];
    }

    int target = sum / 2;
    bool* dp = (bool*)malloc((target + 1) * sizeof(bool));
    memset(dp, 0, (target + 1) * sizeof(bool));
    dp[0] = true;

    for (int i = 0; i < stonesSize; i++) {
        int stoneWeight = stones[i];
        for (int j = target; j >= stoneWeight; j--) {
            dp[j] = dp[j] || dp[j - stoneWeight];
        }
    }

    int max_sum_in_one_partition = 0;
    for (int j = target; j >= 0; j--) {
        if (dp[j]) {
            max_sum_in_one_partition = j;
            break;
        }
    }

    free(dp);

    return sum - 2 * max_sum_in_one_partition;
}