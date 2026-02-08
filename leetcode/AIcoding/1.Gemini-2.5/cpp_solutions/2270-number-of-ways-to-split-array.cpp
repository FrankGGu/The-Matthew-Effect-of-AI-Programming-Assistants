#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int waysToSplit(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long long count = 0;

        // i is the split point after the first subarray (nums[0...i-1])
        // j is the split point after the second subarray (nums[i...j-1])

        // First subarray: nums[0...i-1], sum = prefixSum[i]
        // Second subarray: nums[i...j-1], sum = prefixSum[j] - prefixSum[i]
        // Third subarray: nums[j...n-1], sum = prefixSum[n] - prefixSum[j]

        // Constraints on i and j:
        // 1. First subarray must be non-empty: i >= 1
        // 2. Second subarray must be non-empty: j-1 >= i  => j >= i+1
        // 3. Third subarray must be non-empty: n-1 >= j   => j <= n-1

        // Combining these, i ranges from 1 to n-2.
        // For a fixed i, j ranges from i+1 to n-1.

        for (int i = 1; i <= n - 2; ++i) {
            long long sum1 = prefixSum[i];

            // Conditions for a valid split:
            // 1. sum1 <= sum2
            //    prefixSum[i] <= prefixSum[j] - prefixSum[i]
            //    2 * prefixSum[i] <= prefixSum[j]
            //
            // 2. sum2 <= sum3
            //    prefixSum[j] - prefixSum[i] <= prefixSum[n] - prefixSum[j]
            //    2 * prefixSum[j] <= prefixSum[n] + prefixSum[i]
            //    prefixSum[j] <= (prefixSum[n] + prefixSum[i]) / 2

            long long min_Pj = 2 * sum1;
            long long max_Pj = (prefixSum[n] + sum1) / 2;

            // We need to find the number of valid 'j' indices such that:
            // i+1 <= j <= n-1
            // min_Pj <= prefixSum[j] <= max_Pj

            // The range of prefix sums to search within is prefixSum[i+1], ..., prefixSum[n-1].
            // In terms of iterators, this is [prefixSum.begin() + i + 1, prefixSum.begin() + n).
            auto it_low = std::lower_bound(prefixSum.begin() + i + 1, prefixSum.begin() + n, min_Pj);
            auto it_high = std::upper_bound(prefixSum.begin() + i + 1, prefixSum.begin() + n, max_Pj);

            // The number of valid 'j's for the current 'i' is the distance between these iterators.
            count += std::distance(it_low, it_high);
        }

        return static_cast<int>(count);
    }
};