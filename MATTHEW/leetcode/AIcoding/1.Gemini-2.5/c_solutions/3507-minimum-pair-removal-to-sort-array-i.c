#include <stdlib.h>

int minimumPairRemoval(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int* dp = (int*)malloc(numsSize * sizeof(int));
    if (dp == NULL) {
        // Handle allocation failure if necessary, though LeetCode environments usually guarantee success
        return -1; 
    }

    int max_len = 0;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1; 
        for (int j = 0; j < i; j++) {
            if (nums[i] >= nums[j]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                }
            }
        }
        if (dp[i] > max_len) {
            max_len = dp[i];
        }
    }

    free(dp); 

    return numsSize - max_len;
}