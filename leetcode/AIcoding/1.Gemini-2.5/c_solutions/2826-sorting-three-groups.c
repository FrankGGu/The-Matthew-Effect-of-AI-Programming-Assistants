#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int minOperations(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    // count_val[val][k] stores the count of 'val' in nums[0...k-1]
    // val ranges from 1 to 50, k ranges from 0 to numsSize
    int count_val[51][101];
    memset(count_val, 0, sizeof(count_val));

    // Precompute prefix counts for each value
    for (int k = 1; k <= numsSize; ++k) {
        for (int val = 1; val <= 50; ++val) {
            count_val[val][k] = count_val[val][k-1];
        }
        // Increment count for the current element nums[k-1]
        count_val[nums[k-1]][k]++;
    }

    int max_kept = 0;

    // Iterate over all possible values for v1, v2, v3 such that v1 <= v2 <= v3
    // These values represent the target values for elements in group 1, 2, and 3 respectively.
    for (int v1 = 1; v1 <= 50; ++v1) {
        for (int v2 = v1; v2 <= 50; ++v2) {
            for (int v3 = v2; v3 <= 50; ++v3) {
                // val_diff[k] = (count of v2 in nums[0...k-1]) - (count of v3 in nums[0...k-1])
                // This is used to optimize the calculation for groups 2 and 3.
                int val_diff[101];
                for (int k = 0; k <= numsSize; ++k) {
                    val_diff[k] = count_val[v2][k] - count_val[v3][k];
                }

                // max_val_diff_suffix[k] stores the maximum of val_diff[j] for j from k to numsSize.
                // This helps find the optimal split point p2 for groups 2 and 3 efficiently.
                int max_val_diff_suffix[101];
                max_val_diff_suffix[numsSize] = val_diff[numsSize];
                for (int k = numsSize - 1; k >= 0; --k) {
                    max_val_diff_suffix[k] = max(val_diff[k], max_val_diff_suffix[k+1]);
                }

                int current_max_kept_for_v_triplet = 0;
                // Iterate over all possible split points p1
                // p1 is the exclusive end of group 1, and inclusive start of group 2.
                // nums[0...p1-1] forms group 1
                // nums[p1...numsSize-1] forms groups 2 and 3
                for (int p1 = 0; p1 <= numsSize; ++p1) {
                    int kept_g1 = count_val[v1][p1]; // Count of v1 in the first group (nums[0...p1-1])

                    // For the remaining subarray nums[p1...numsSize-1], we need to find an optimal p2
                    // to split it into group 2 (nums[p1...p2-1]) and group 3 (nums[p2...numsSize-1]).
                    // The number of kept elements in this part is:
                    // (count of v2 in nums[p1...p2-1]) + (count of v3 in nums[p2...numsSize-1])
                    // This can be written as:
                    // (count_val[v2][p2] - count_val[v2][p1]) + (count_val[v3][numsSize] - count_val[v3][p2])
                    // Rearranging terms:
                    // (count_val[v2][p2] - count_val[v3][p2]) + (count_val[v3][numsSize] - count_val[v2][p1])
                    // The first part is val_diff[p2]. We need to maximize val_diff[p2] for p2 from p1 to numsSize.
                    // This maximum is given by max_val_diff_suffix[p1].
                    // The second part (count_val[v3][numsSize] - count_val[v2][p1]) is constant for a fixed p1.
                    int max_g2_g3_part = max_val_diff_suffix[p1] + (count_val[v3][numsSize] - count_val[v2][p1]);

                    current_max_kept_for_v_triplet = max(current_max_kept_for_v_triplet, kept_g1 + max_g2_g3_part);
                }
                max_kept = max(max_kept, current_max_kept_for_v_triplet);
            }
        }
    }

    // The minimum number of operations is the total number of elements minus the maximum number of elements we could keep.
    return numsSize - max_kept;
}