#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int freshDonuts(int batchSize, int *groups, int groupsSize) {
    int count[batchSize];
    for (int i = 0; i < batchSize; i++) {
        count[i] = 0;
    }

    for (int i = 0; i < groupsSize; i++) {
        count[groups[i] % batchSize]++;
    }

    int dp[1 << batchSize];
    for (int i = 0; i < (1 << batchSize); i++) {
        dp[i] = -1;
    }

    dp[0] = 0;

    int solve(int mask, int remain) {
        if (dp[mask] != -1) {
            return dp[mask];
        }

        int ans = 0;
        for (int i = 1; i < batchSize; i++) {
            if (count[i] > 0 && !(mask & (1 << i))) {
                count[i]--;
                ans = max(ans, (remain == 0) + solve(mask | (1 << i), (remain + batchSize - i) % batchSize));
                count[i]++;
            }
        }

        return dp[mask] = ans;
    }

    int ans = count[0];
    count[0] = 0;
    ans += solve(0, 0);

    return ans;
}