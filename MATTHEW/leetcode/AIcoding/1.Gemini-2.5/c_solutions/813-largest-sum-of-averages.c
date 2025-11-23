#include <stdlib.h> 
#include <math.h>   

double largestSumOfAverages(int* nums, int numsSize, int k) {
    int n = numsSize;

    // prefix_sum[i] stores the sum of nums[0]...nums[i-1]
    // prefix_sum[0] will be 0
    double* prefix_sum = (double*)calloc(n + 1, sizeof(double));
    for (int i = 0; i < n; i++) {
        prefix_sum[i+1] = prefix_sum[i] + nums[i];
    }

    // dp[i][j] stores the maximum sum of averages for the first 'i' elements
    // partitioned into exactly 'j' subarrays.
    // dp table size (n+1) x (k+1)
    double** dp = (double**)malloc((n + 1) * sizeof(double*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (double*)calloc(k + 1, sizeof(double));
    }

    // Base case: j = 1 (partition into 1 subarray)
    // For the first 'i' elements, partitioned into 1 subarray,
    // the average is simply their sum divided by 'i'.
    for (int i = 1; i <= n; i++) {
        dp[i][1] = prefix_sum[i] / i;
    }

    // Fill the dp table
    // j: number of partitions (from 2 to k)
    for (int j = 2; j <= k; j++) {
        // i: number of elements considered (from j to n)
        // 'i' must be at least 'j' to form 'j' partitions
        for (int i = j; i <= n; i++) {
            // To calculate dp[i][j], we consider the last subarray.
            // This last subarray ends at index i-1 (0-indexed).
            // It could start at any index 'p' (0-indexed) such that
            // elements nums[0]...nums[p-1] form 'j-1' subarrays,
            // and elements nums[p]...nums[i-1] form the j-th subarray.
            // So, 'p' elements are used for 'j-1' subarrays, and 'i-p' elements for the last one.
            // 'p' must be at least 'j-1' (minimum elements for 'j-1' subarrays).
            // 'p' must be at most 'i-1' (leaving at least 1 element for the last subarray).
            for (int p = j - 1; p < i; p++) {
                double current_subarray_sum = prefix_sum[i] - prefix_sum[p];
                double current_subarray_len = i - p;
                double current_avg = current_subarray_sum / current_subarray_len;
                dp[i][j] = fmax(dp[i][j], dp[p][j-1] + current_avg);
            }
        }
    }

    double result = dp[n][k];

    // Free allocated memory
    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefix_sum);

    return result;
}