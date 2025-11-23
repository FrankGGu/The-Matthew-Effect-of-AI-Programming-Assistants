#include <vector>
#include <unordered_set>
#include <numeric>

class Solution {
public:
    std::vector<int> distinctDifferenceArray(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> ans(n);

        std::vector<int> prefix_distinct_counts(n);
        std::vector<int> suffix_distinct_counts(n + 1, 0); // suffix_distinct_counts[i] stores distinct count for nums[i...n-1]

        std::unordered_set<int> current_set;

        // Calculate prefix_distinct_counts
        for (int i = 0; i < n; ++i) {
            current_set.insert(nums[i]);
            prefix_distinct_counts[i] = current_set.size();
        }

        current_set.clear();

        // Calculate suffix_distinct_counts
        // suffix_distinct_counts[i] will store distinct elements in nums[i...n-1]
        // suffix_distinct_counts[n] is 0 (empty suffix)
        for (int i = n - 1; i >= 0; --i) {
            current_set.insert(nums[i]);
            suffix_distinct_counts[i] = current_set.size();
        }

        // Calculate the final difference array
        for (int i = 0; i < n; ++i) {
            // For diff[i], we need distinct(prefix[i]) and distinct(suffix[i+1])
            // distinct(prefix[i]) is prefix_distinct_counts[i]
            // distinct(suffix[i+1]) is suffix_distinct_counts[i+1]
            ans[i] = prefix_distinct_counts[i] - suffix_distinct_counts[i + 1];
        }

        return ans;
    }
};