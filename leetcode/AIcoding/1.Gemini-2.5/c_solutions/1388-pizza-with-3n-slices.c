#include <stdlib.h>
#include <string.h>

#define NEGINF -1000000000

int max(int a, int b) {
    return a > b ? a : b;
}

int solve(int* arr, int size, int k) {
    int dp[size + 1][k + 1];

    for (int i = 0; i <= size; ++i) {
        for (int j = 0; j <= k; ++j) {
            dp[i][j] = NEGINF;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= size; ++i) {
        dp[i][0] = 0;
        for (int j = 1; j <= k; ++j) {
            // Option 1: Don't pick current element (arr[i-1])
            if (dp[i-1][j] != NEGINF) {
                dp[i][j] = max(dp[i][j], dp[i-1][j]);
            }

            // Option 2: Pick current element (arr[i-1])
            // If we pick arr[i-1], we cannot pick arr[i-2].
            // So we need to have picked j-1 elements from arr[0...i-3] (if i >= 2)
            // or 0 elements from before arr[0] (if i == 1 and j == 1).
            int pick_val = NEGINF;
            if (i == 1 && j == 1) {
                pick_val = arr[0];
            } else if (i >= 2) {
                if (dp[i-2][j-1] != NEGINF) {
                    pick_val = dp[i-2][j-1] + arr[i-1];
                }
            }
            dp[i][j] = max(dp[i][j], pick_val);
        }
    }
    return dp[size][k];
}

int maxSizeSlices(int* slices, int slicesSize) {
    int k_to_pick = slicesSize / 3;

    int* slices_case1 = (int*)malloc(sizeof(int) * (slicesSize - 1));
    for (int i = 0; i < slicesSize - 1; ++i) {
        slices_case1[i] = slices[i];
    }
    int res1 = solve(slices_case1, slicesSize - 1, k_to_pick);
    free(slices_case1);

    int* slices_case2 = (int*)malloc(sizeof(int) * (slicesSize - 1));
    for (int i = 0; i < slicesSize - 1; ++i) {
        slices_case2[i] = slices[i+1];
    }
    int res2 = solve(slices_case2, slicesSize - 1, k_to_pick);
    free(slices_case2);

    return max(res1, res2);
}