#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minGroupsForValidAssignment(std::vector<int>& nums) {
        std::unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        int min_count = nums.size();
        std::vector<int> count_values;
        count_values.reserve(counts.size());
        for (auto const& pair : counts) {
            min_count = std::min(min_count, pair.second);
            count_values.push_back(pair.second);
        }

        for (int k = min_count; k >= 1; --k) {
            bool is_k_valid = true;
            for (int c : count_values) {
                if (c / k < (c + k) / (k + 1)) {
                    is_k_valid = false;
                    break;
                }
            }

            if (is_k_valid) {
                int total_groups = 0;
                for (int c : count_values) {
                    total_groups += (c + k) / (k + 1);
                }
                return total_groups;
            }
        }

        return nums.size();
    }
};