#include <vector>
#include <map>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minimumSeconds(std::vector<int>& nums) {
        int n = nums.size();
        std::map<int, std::vector<int>> val_to_indices;

        for (int i = 0; i < n; ++i) {
            val_to_indices[nums[i]].push_back(i);
        }

        int min_total_seconds = std::numeric_limits<int>::max();

        for (auto const& [val, indices_list] : val_to_indices) {
            if (indices_list.size() == n) {
                return 0; 
            }

            int max_seconds_for_this_value = 0;

            for (size_t i = 0; i < indices_list.size() - 1; ++i) {
                int diff = indices_list[i+1] - indices_list[i];
                max_seconds_for_this_value = std::max(max_seconds_for_this_value, diff / 2);
            }

            int first_idx = indices_list[0];
            int last_idx = indices_list.back();
            int circular_diff = n - (last_idx - first_idx);
            max_seconds_for_this_value = std::max(max_seconds_for_this_value, circular_diff / 2);

            min_total_seconds = std::min(min_total_seconds, max_seconds_for_this_value);
        }

        return min_total_seconds;
    }
};