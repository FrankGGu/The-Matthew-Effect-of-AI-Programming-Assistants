#include <vector>
#include <map>

class Solution {
public:
    long long countSubarrays(std::vector<int>& nums, int k) {
        long long total_count = 0;
        std::map<int, int> current_ands; // Stores (AND_value, count_of_subarrays_ending_at_previous_index_with_this_AND_value)

        for (int x : nums) {
            std::map<int, int> new_ands;

            // Subarray [i, i] ending at current index with value x
            new_ands[x]++; 

            // Extend subarrays from previous index
            for (auto const& [val, count] : current_ands) {
                int new_val = val & x;
                new_ands[new_val] += count;
            }

            // Update total_count for subarrays ending at current index
            if (new_ands.count(k)) {
                total_count += new_ands[k];
            }

            current_ands = new_ands;
        }

        return total_count;
    }
};