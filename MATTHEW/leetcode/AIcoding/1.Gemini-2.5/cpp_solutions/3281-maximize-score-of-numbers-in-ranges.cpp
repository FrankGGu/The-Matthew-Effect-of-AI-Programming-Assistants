#include <vector>
#include <algorithm>

class Solution {
public:
    long long maximizeScore(std::vector<int>& nums, int k, std::vector<std::vector<int>>& ranges) {
        if (ranges.empty()) {
            return 0;
        }

        std::sort(ranges.begin(), ranges.end());
        std::vector<std::vector<int>> merged_ranges;
        merged_ranges.push_back(ranges[0]);
        for (size_t i = 1; i < ranges.size(); ++i) {
            if (ranges[i][0] <= merged_ranges.back()[1]) {
                merged_ranges.back()[1] = std::max(merged_ranges.back()[1], ranges[i][1]);
            } else {
                merged_ranges.push_back(ranges[i]);
            }
        }

        std::sort(nums.begin(), nums.end());
        std::vector<int> candidates;
        int num_idx = 0;
        int range_idx = 0;
        while (num_idx < (int)nums.size() && range_idx < (int)merged_ranges.size()) {
            int num = nums[num_idx];
            int start = merged_ranges[range_idx][0];
            int end = merged_ranges[range_idx][1];

            if (num < start) {
                num_idx++;
            } else if (num > end) {
                range_idx++;
            } else {
                if (candidates.empty() || candidates.back() != num) {
                    candidates.push_back(num);
                }
                num_idx++;
            }
        }

        if (candidates.empty()) {
            return 0;
        }

        int m = candidates.size();
        std::vector<long long> dp(m + 1, 0);

        for (int i = 1; i <= m; ++i) {
            long long val = candidates[i - 1];
            long long target = val - k;

            auto it = std::lower_bound(candidates.begin(), candidates.begin() + i - 1, target);
            int p_idx = (it - candidates.begin()) - 1;

            long long prev_score = (p_idx < 0) ? 0 : dp[p_idx + 1];

            long long score_with_val = val + prev_score;
            long long score_without_val = dp[i - 1];

            dp[i] = std::max(score_with_val, score_without_val);
        }

        return dp[m];
    }
};