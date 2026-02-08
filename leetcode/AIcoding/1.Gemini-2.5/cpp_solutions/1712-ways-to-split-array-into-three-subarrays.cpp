#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int waysToSplit(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        long long total_ways = 0;
        long long MOD = 1e9 + 7;

        // i is the exclusive end index of the left subarray.
        // The left subarray is nums[0...i-1], its sum is prefix[i].
        // i must be at least 1 (left subarray non-empty).
        // i must be at most n-2 (to allow mid and right subarrays to be non-empty).
        for (int i = 1; i <= n - 2; ++i) {
            long long sum_left = prefix[i];

            // For a chosen 'i', we need to find 'j' (exclusive end index of mid subarray).
            // The mid subarray is nums[i...j-1], its sum is prefix[j] - prefix[i].
            // The right subarray is nums[j...n-1], its sum is prefix[n] - prefix[j].
            // j must be at least i+1 (mid subarray non-empty).
            // j must be at most n-1 (right subarray non-empty).

            // Conditions:
            // 1. sum_left <= sum_mid
            //    prefix[i] <= prefix[j] - prefix[i]
            //    2 * prefix[i] <= prefix[j]
            long long min_prefix_j = 2 * sum_left;

            // 2. sum_mid <= sum_right
            //    prefix[j] - prefix[i] <= prefix[n] - prefix[j]
            //    2 * prefix[j] <= prefix[n] + prefix[i]
            //    prefix[j] <= (prefix[n] + prefix[i]) / 2
            long long max_prefix_j = (prefix[n] + sum_left) / 2;

            // We need to find the count of 'j' such that:
            // i + 1 <= j <= n - 1
            // min_prefix_j <= prefix[j] <= max_prefix_j

            // The search range for j is from index i+1 up to n-1.
            // In terms of iterators for the prefix array, this is [prefix.begin() + i + 1, prefix.begin() + n).

            // Find the first j such that prefix[j] >= min_prefix_j
            auto it_low = std::lower_bound(prefix.begin() + i + 1, prefix.begin() + n, min_prefix_j);

            // Find the first j such that prefix[j] > max_prefix_j
            auto it_high = std::upper_bound(prefix.begin() + i + 1, prefix.begin() + n, max_prefix_j);

            // The number of valid j's for the current i is the distance between these iterators.
            long long count_j = std::distance(it_low, it_high);
            total_ways = (total_ways + count_j) % MOD;
        }

        return static_cast<int>(total_ways);
    }
};