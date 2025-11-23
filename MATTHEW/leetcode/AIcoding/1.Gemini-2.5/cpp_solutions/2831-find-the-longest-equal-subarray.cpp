#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int longestEqualSubarray(std::vector<int>& nums, int k) {
        std::map<int, std::vector<int>> val_indices;
        for (int i = 0; i < nums.size(); ++i) {
            val_indices[nums[i]].push_back(i);
        }

        int overall_max_len = 0;

        for (auto const& [val, indices] : val_indices) {
            if (indices.empty()) {
                continue;
            }

            int left = 0;
            for (int right = 0; right < indices.size(); ++right) {
                // The current window of 'val's is from indices[left] to indices[right].
                // Number of 'val's in this window is (right - left + 1).
                // The span in the original array is from nums[indices[left]] to nums[indices[right]].
                // Total elements in this span: (indices[right] - indices[left] + 1).
                // Number of non-'val' elements within this span that need to be deleted:
                // (total elements in span) - (count of 'val's in span)
                int deletions_needed = (indices[right] - indices[left] + 1) - (right - left + 1);

                // If deletions needed exceed k, shrink the window from the left.
                while (deletions_needed > k) {
                    left++;
                    // Recalculate deletions_needed for the new window [indices[left]...indices[right]].
                    deletions_needed = (indices[right] - indices[left] + 1) - (right - left + 1);
                }

                // The current window [indices[left]...indices[right]] is valid.
                // The number of 'val's in this window is (right - left + 1).
                overall_max_len = std::max(overall_max_len, right - left + 1);
            }
        }

        return overall_max_len;
    }
};