#include <vector>
#include <algorithm> // For std::max, std::min
#include <climits>   // For LLONG_MIN

class Solution {
public:
    long long maximumTripletValue(std::vector<int>& nums) {
        int n = nums.size();

        // Problem constraints state n >= 3, so no need to handle n < 3 explicitly.

        // prefix_max[i] stores the maximum value in nums[0...i]
        std::vector<int> prefix_max(n);
        prefix_max[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            prefix_max[i] = std::max(nums[i], prefix_max[i-1]);
        }

        // suffix_max[i] stores the maximum value in nums[i...n-1]
        // suffix_min[i] stores the minimum value in nums[i...n-1]
        std::vector<int> suffix_max(n);
        std::vector<int> suffix_min(n);
        suffix_max[n-1] = nums[n-1];
        suffix_min[n-1] = nums[n-1];
        for (int i = n - 2; i >= 0; --i) {
            suffix_max[i] = std::max(nums[i], suffix_max[i+1]);
            suffix_min[i] = std::min(nums[i], suffix_min[i+1]);
        }

        long long max_triplet_value = LLONG_MIN; // Initialize with the smallest possible long long value

        // Iterate j from 1 to n-2. For each j, we need to find i < j and k > j.
        for (int j = 1; j < n - 1; ++j) {
            // The maximum value for nums[i] where i < j is prefix_max[j-1].
            long long max_val_i = prefix_max[j-1];

            // The middle element nums[j].
            long long current_num_j = nums[j];

            // The difference (nums[i] - nums[j]).
            long long current_diff = max_val_i - current_num_j;

            // To maximize (current_diff) * nums[k]:
            // If current_diff is positive, we want nums[k] to be as large as possible.
            // This is suffix_max[j+1].
            // If current_diff is negative, we want nums[k] to be as small (most negative) as possible
            // to make the product positive and large. This is suffix_min[j+1].
            // If current_diff is zero, both products will be zero.

            // Consider nums[k] being the maximum value in nums[j+1...n-1]
            long long max_val_k = suffix_max[j+1];
            long long candidate1 = current_diff * max_val_k;
            max_triplet_value = std::max(max_triplet_value, candidate1);

            // Consider nums[k] being the minimum value in nums[j+1...n-1]
            long long min_val_k = suffix_min[j+1];
            long long candidate2 = current_diff * min_val_k;
            max_triplet_value = std::max(max_triplet_value, candidate2);
        }

        return max_triplet_value;
    }
};