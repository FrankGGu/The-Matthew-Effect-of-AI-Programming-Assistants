#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> largestDivisibleSubset(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return {};
        }

        std::sort(nums.begin(), nums.end());

        std::vector<int> dp(n, 1);
        std::vector<int> parent(n, -1);

        int max_len = 1;
        int max_index = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] % nums[j] == 0 && 1 + dp[j] > dp[i]) {
                    dp[i] = 1 + dp[j];
                    parent[i] = j;
                }
            }
            if (dp[i] > max_len) {
                max_len = dp[i];
                max_index = i;
            }
        }

        std::vector<int> result;
        int curr_index = max_index;
        while (curr_index != -1) {
            result.push_back(nums[curr_index]);
            curr_index = parent[curr_index];
        }

        return result;
    }
};