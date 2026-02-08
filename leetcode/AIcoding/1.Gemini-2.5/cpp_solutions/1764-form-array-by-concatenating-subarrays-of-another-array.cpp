#include <vector>

class Solution {
public:
    bool canChoose(std::vector<std::vector<int>>& groups, std::vector<int>& nums) {
        int group_idx = 0;
        int nums_current_pos = 0;

        while (group_idx < groups.size()) {
            const std::vector<int>& current_group = groups[group_idx];
            int current_group_len = current_group.size();

            bool found_current_group = false;

            // Search for current_group in nums starting from nums_current_pos.
            // The loop condition `i <= (int)nums.size() - current_group_len` ensures
            // that there is enough space for the current_group to fit.
            for (int i = nums_current_pos; i <= (int)nums.size() - current_group_len; ++i) {
                bool match = true;
                for (int j = 0; j < current_group_len; ++j) {
                    if (nums[i + j] != current_group[j]) {
                        match = false;
                        break;
                    }
                }

                if (match) {
                    found_current_group = true;
                    // Update nums_current_pos to the index immediately after the matched subarray.
                    // This ensures the next group is searched for in a non-overlapping segment.
                    nums_current_pos = i + current_group_len;
                    group_idx++; // Move to the next group
                    break; // Break from the inner loop (found current group, move to next group)
                }
            }

            if (!found_current_group) {
                return false; // Current group could not be found in the remaining part of nums
            }
        }

        return true; // All groups were successfully found
    }
};