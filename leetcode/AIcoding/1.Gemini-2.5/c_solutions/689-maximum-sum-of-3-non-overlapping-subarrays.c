#include <stdlib.h> // For malloc and free

int* maxSumOfThreeSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = 3;

    // W[i] will store the sum of the subarray nums[i...i+k-1]
    // The length of W will be numsSize - k + 1
    int W_len = numsSize - k + 1;
    long long* W = (long long*)malloc(W_len * sizeof(long long));

    // Calculate W[0]
    long long current_sum = 0;
    for (int i = 0; i < k; i++) {
        current_sum += nums[i];
    }
    W[0] = current_sum;

    // Calculate the rest of W using a sliding window approach
    for (int i = 1; i < W_len; i++) {
        current_sum = current_sum - nums[i-1] + nums[i+k-1];
        W[i] = current_sum;
    }

    // leftMaxIdx[i] stores the starting index of the k-length subarray
    // with the maximum sum in the range W[0...i].
    // If there are ties, the smallest index is preferred for lexicographical order.
    int* leftMaxIdx = (int*)malloc(W_len * sizeof(int));
    leftMaxIdx[0] = 0;
    for (int i = 1; i < W_len; i++) {
        if (W[i] > W[leftMaxIdx[i-1]]) {
            leftMaxIdx[i] = i;
        } else {
            leftMaxIdx[i] = leftMaxIdx[i-1];
        }
    }

    // rightMaxIdx[i] stores the starting index of the k-length subarray
    // with the maximum sum in the range W[i...W_len-1].
    // If there are ties, the smallest index is preferred for lexicographical order.
    int* rightMaxIdx = (int*)malloc(W_len * sizeof(int));
    rightMaxIdx[W_len - 1] = W_len - 1;
    for (int i = W_len - 2; i >= 0; i--) {
        // Use >= to prefer the smaller index 'i' if sums are equal
        if (W[i] >= W[rightMaxIdx[i+1]]) { 
            rightMaxIdx[i] = i;
        } else {
            rightMaxIdx[i] = rightMaxIdx[i+1];
        }
    }

    long long max_total_sum = -1; // Sums are non-negative, so -1 is a safe initial value
    int* result = (int*)malloc(3 * sizeof(int));

    // Iterate through all possible starting indices for the middle subarray (j)
    // The first subarray (i_idx) must end before j starts: i_idx + k <= j => i_idx <= j - k
    // The third subarray (l_idx) must start after j ends: l_idx >= j + k
    // So, j must be at least k, and at most numsSize - 2*k.
    for (int j = k; j <= numsSize - 2 * k; j++) {
        int i_idx = leftMaxIdx[j-k];
        int l_idx = rightMaxIdx[j+k];

        long long current_total_sum = W[i_idx] + W[j] + W[l_idx];

        // If a new maximum sum is found, update the result
        // If sums are equal, the first encountered (lexicographically smallest)
        // result will be kept due to the iteration order of j and construction of leftMaxIdx/rightMaxIdx.
        if (current_total_sum > max_total_sum) {
            max_total_sum = current_total_sum;
            result[0] = i_idx;
            result[1] = j;
            result[2] = l_idx;
        }
    }

    // Free dynamically allocated memory
    free(W);
    free(leftMaxIdx);
    free(rightMaxIdx);

    return result;
}