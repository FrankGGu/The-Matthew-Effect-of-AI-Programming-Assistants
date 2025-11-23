#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minIncompatibility(int* nums, int numsSize, int k) {
    int n = numsSize;
    int groupSize = n / k;
    int maskLimit = 1 << n;
    int dp[maskLimit];
    for (int i = 0; i < maskLimit; i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int mask = 0; mask < maskLimit; mask++) {
        if (dp[mask] == -1) continue;

        int count = 0;
        for (int i = 0; i < n; i++) {
            if ((mask >> i) & 1) count++;
        }

        if (count % groupSize == 0) {
            int subset = 0;
            for (int i = 0; i < n; i++) {
                if (!((mask >> i) & 1)) {
                    subset |= (1 << i);
                }
            }

            for (int submask = subset; submask > 0; submask = (submask - 1) & subset) {
                if (__builtin_popcount(submask) == groupSize) {
                    int minVal = INT_MAX, maxVal = INT_MIN;
                    int valid = 1;
                    int seen[201] = {0};

                    for (int i = 0; i < n; i++) {
                        if ((submask >> i) & 1) {
                            if (seen[nums[i]]) {
                                valid = 0;
                                break;
                            }
                            seen[nums[i]] = 1;
                            minVal = (nums[i] < minVal) ? nums[i] : minVal;
                            maxVal = (nums[i] > maxVal) ? nums[i] : maxVal;
                        }
                    }

                    if (valid) {
                        int newMask = mask | submask;
                        int incompatibility = maxVal - minVal;
                        if (dp[newMask] == -1 || dp[newMask] > dp[mask] + incompatibility) {
                            dp[newMask] = dp[mask] + incompatibility;
                        }
                    }
                }
            }
        }
    }

    return dp[maskLimit - 1];
}