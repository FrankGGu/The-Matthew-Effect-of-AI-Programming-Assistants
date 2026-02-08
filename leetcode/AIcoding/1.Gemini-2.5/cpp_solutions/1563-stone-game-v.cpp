#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int stoneGameV(std::vector<int>& stoneValue) {
        int n = stoneValue.size();
        if (n <= 1) {
            return 0;
        }

        std::vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + stoneValue[i];
        }

        std::vector<std::vector<int>> memo(n, std::vector<int>(n, -1));

        return solve(0, n - 1, prefix, memo);
    }

private:
    int solve(int i, int j, const std::vector<int>& prefix, std::vector<std::vector<int>>& memo) {
        if (i >= j) {
            return 0;
        }
        if (memo[i][j] != -1) {
            return memo[i][j];
        }

        int max_score = 0;
        for (int k = i; k < j; ++k) {
            int left_sum = prefix[k + 1] - prefix[i];
            int right_sum = prefix[j + 1] - prefix[k + 1];
            int current_score = 0;

            if (left_sum < right_sum) {
                current_score = left_sum + solve(i, k, prefix, memo);
            } else if (left_sum > right_sum) {
                current_score = right_sum + solve(k + 1, j, prefix, memo);
            } else {
                current_score = left_sum + std::max(solve(i, k, prefix, memo), solve(k + 1, j, prefix, memo));
            }
            max_score = std::max(max_score, current_score);
        }

        return memo[i][j] = max_score;
    }
};