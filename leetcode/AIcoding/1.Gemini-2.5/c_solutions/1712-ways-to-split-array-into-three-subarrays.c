#include <stdlib.h> // For malloc and free

long long waysToSplitArray(int* nums, int numsSize) {
    if (numsSize < 3) {
        return 0;
    }

    // Calculate prefix sums
    long long* P = (long long*)malloc((numsSize + 1) * sizeof(long long));
    P[0] = 0;
    for (int k = 0; k < numsSize; k++) {
        P[k + 1] = P[k] + nums[k];
    }

    long long ans = 0;
    int left_j_ptr = 2; // Smallest possible j for i=1 is 2 (P[2] is sum of first two elements)
    int right_j_ptr = 2;

    // i represents the split point after the first subarray (nums[0...i-1])
    // P[i] is sum(left)
    // i ranges from 1 to numsSize - 2
    // The first subarray (nums[0...i-1]) must be non-empty, so i >= 1.
    // The second subarray (nums[i...j-1]) must be non-empty, so j > i.
    // The third subarray (nums[j...numsSize-1]) must be non-empty, so j < numsSize.
    // This implies i <= numsSize - 2.
    for (int i = 1; i <= numsSize - 2; i++) {
        long long sum_left = P[i];
        long long min_Pj_val = 2LL * sum_left;
        long long max_Pj_numerator = P[numsSize] + sum_left; // P[numsSize] is total sum

        // Move left_j_ptr to find the first j such that P[j] >= min_Pj_val
        // left_j_ptr must be at least i + 1
        if (left_j_ptr <= i) {
            left_j_ptr = i + 1;
        }
        // j must be less than numsSize (to ensure the third subarray is non-empty)
        while (left_j_ptr < numsSize && P[left_j_ptr] < min_Pj_val) {
            left_j_ptr++;
        }

        // Move right_j_ptr to find the first j such that P[j] * 2 > max_Pj_numerator
        // right_j_ptr must be at least i + 1
        if (right_j_ptr <= i) {
            right_j_ptr = i + 1;
        }
        // j must be less than numsSize
        while (right_j_ptr < numsSize && P[right_j_ptr] * 2 <= max_Pj_numerator) {
            right_j_ptr++;
        }

        // The valid range for j is [left_j_ptr, right_j_ptr - 1].
        // We need to ensure left_j_ptr is a valid index and the range is not empty.
        // If left_j_ptr is less than numsSize and left_j_ptr is less than right_j_ptr,
        // then there are valid j values.
        if (left_j_ptr < numsSize && left_j_ptr < right_j_ptr) {
            ans += (right_j_ptr - left_j_ptr);
        }
    }

    free(P);
    return ans;
}