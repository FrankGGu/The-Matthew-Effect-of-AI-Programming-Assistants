#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int maximizeTheNumberOfPartitions(std::vector<int>& nums) {
        int n = nums.size();

        // prefix_dp[i] stores the maximum number of partitions in nums[0...i-1]
        std::vector<int> prefix_dp(n + 1, 0);
        std::unordered_map<int, int> last_seen_prefix;
        int partition_start_idx_prefix = 0;

        for (int i = 0; i < n; ++i) {
            // Check if nums[i] is a duplicate within the current partition (nums[partition_start_idx_prefix ... i-1])
            if (last_seen_prefix.count(nums[i]) && last_seen_prefix[nums[i]] >= partition_start_idx_prefix) {
                // If it's a duplicate, a new partition must start.
                // The new partition will effectively start after the last occurrence of nums[i] that caused the conflict.
                partition_start_idx_prefix = last_seen_prefix[nums[i]] + 1;
            }
            // The number of partitions up to index i (i.e., for nums[0...i]) is
            // the number of partitions up to `partition_start_idx_prefix - 1` plus one for the current partition.
            prefix_dp[i+1] = prefix_dp[partition_start_idx_prefix] + 1;
            last_seen_prefix[nums[i]] = i;
        }

        // suffix_dp[i] stores the maximum number of partitions in nums[i...n-1]
        std::vector<int> suffix_dp(n + 1, 0);
        std::unordered_map<int, int> last_seen_suffix;
        int partition_end_idx_suffix = n - 1; // Rightmost index of the current suffix partition

        for (int i = n - 1; i >= 0; --i) {
            // Check if nums[i] is a duplicate within the current suffix partition (nums[i+1 ... partition_end_idx_suffix])
            if (last_seen_suffix.count(nums[i]) && last_seen_suffix[nums[i]] <= partition_end_idx_suffix) {
                // If it's a duplicate, a new partition must start.
                // The new partition will effectively end before the next occurrence of nums[i] that caused the conflict.
                partition_end_idx_suffix = last_seen_suffix[nums[i]] - 1;
            }
            // The number of partitions from index i (i.e., for nums[i...n-1]) is
            // the number of partitions from `partition_end_idx_suffix + 1` plus one for the current partition.
            suffix_dp[i] = suffix_dp[partition_end_idx_suffix + 1] + 1;
            last_seen_suffix[nums[i]] = i;
        }

        // Initialize max_partitions with the case of no operations
        int max_partitions = prefix_dp[n];

        // Iterate through all possible indices `k` where an operation might be performed.
        // If nums[k] is changed to a unique value, it effectively merges the last partition
        // of nums[0...k-1] and the first partition of nums[k+1...n-1].
        // The total number of partitions becomes (partitions in prefix) + (partitions in suffix).
        for (int k = 0; k < n; ++k) {
            max_partitions = std::max(max_partitions, prefix_dp[k] + suffix_dp[k+1]);
        }

        return max_partitions;
    }
};