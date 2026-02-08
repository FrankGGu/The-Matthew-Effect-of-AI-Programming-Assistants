#include <vector>

class Solution {
public:
    std::vector<bool> isArraySpecial(std::vector<int>& nums, std::vector<std::vector<int>>& queries) {
        int n = nums.size();
        std::vector<int> prefix_violations(n, 0);
        for (int i = 1; i < n; ++i) {
            prefix_violations[i] = prefix_violations[i - 1];
            if ((nums[i] % 2) == (nums[i - 1] % 2)) {
                prefix_violations[i]++;
            }
        }

        std::vector<bool> result;
        result.reserve(queries.size());
        for (const auto& query : queries) {
            int from = query[0];
            int to = query[1];

            if (from == to) {
                result.push_back(true);
                continue;
            }

            int violations_in_range = prefix_violations[to] - prefix_violations[from];
            result.push_back(violations_in_range == 0);
        }

        return result;
    }
};