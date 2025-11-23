#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> minDifference(std::vector<int>& nums, std::vector<std::vector<int>>& queries) {
        int n = nums.size();
        std::vector<std::vector<int>> prefix_counts(n + 1, std::vector<int>(101, 0));

        for (int i = 0; i < n; ++i) {
            prefix_counts[i + 1] = prefix_counts[i];
            prefix_counts[i + 1][nums[i]]++;
        }

        std::vector<int> result;
        result.reserve(queries.size());

        for (const auto& query : queries) {
            int l = query[0];
            int r = query[1];

            int min_diff = 101;
            int last_val = -1;

            for (int val = 1; val <= 100; ++val) {
                if (prefix_counts[r + 1][val] - prefix_counts[l][val] > 0) {
                    if (last_val != -1) {
                        min_diff = std::min(min_diff, val - last_val);
                    }
                    last_val = val;
                }
            }

            if (min_diff > 100) {
                result.push_back(-1);
            } else {
                result.push_back(min_diff);
            }
        }

        return result;
    }
};