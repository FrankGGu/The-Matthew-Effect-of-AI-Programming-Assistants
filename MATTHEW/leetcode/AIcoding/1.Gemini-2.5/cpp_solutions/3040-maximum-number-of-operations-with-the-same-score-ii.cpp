#include <vector>
#include <algorithm>

class Solution {
public:
    int maxOperations(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 2) {
            return 0;
        }

        std::vector<std::vector<int>> memo(n, std::vector<int>(n, -1));

        int res1 = 1 + solve(nums, 2, n - 1, nums[0] + nums[1], memo);

        memo.assign(n, std::vector<int>(n, -1));
        int res2 = 1 + solve(nums, 0, n - 3, nums[n - 2] + nums[n - 1], memo);

        memo.assign(n, std::vector<int>(n, -1));
        int res3 = 1 + solve(nums, 1, n - 2, nums[0] + nums[n - 1], memo);

        return std::max({res1, res2, res3});
    }

private:
    int solve(const std::vector<int>& nums, int left, int right, int score, std::vector<std::vector<int>>& memo) {
        if (left >= right) {
            return 0;
        }
        if (memo[left][right] != -1) {
            return memo[left][right];
        }

        int ans = 0;

        if (nums[left] + nums[left + 1] == score) {
            ans = std::max(ans, 1 + solve(nums, left + 2, right, score, memo));
        }
        if (nums[right] + nums[right - 1] == score) {
            ans = std::max(ans, 1 + solve(nums, left, right - 2, score, memo));
        }
        if (nums[left] + nums[right] == score) {
            ans = std::max(ans, 1 + solve(nums, left + 1, right - 1, score, memo));
        }

        return memo[left][right] = ans;
    }
};