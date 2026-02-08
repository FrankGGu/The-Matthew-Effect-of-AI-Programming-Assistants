#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int stoneGameII(std::vector<int>& piles) {
        int n = piles.size();
        memo.resize(n, std::vector<int>(n + 1, -1));
        suffix_sum.resize(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            suffix_sum[i] = suffix_sum[i + 1] + piles[i];
        }
        return solve(0, 1, n);
    }

private:
    std::vector<std::vector<int>> memo;
    std::vector<int> suffix_sum;

    int solve(int i, int M, int n) {
        if (i >= n) {
            return 0;
        }
        if (memo[i][M] != -1) {
            return memo[i][M];
        }

        if (i + 2 * M >= n) {
            return memo[i][M] = suffix_sum[i];
        }

        int min_opponent_score = 1e9;
        for (int x = 1; x <= 2 * M; ++x) {
            min_opponent_score = std::min(min_opponent_score, solve(i + x, std::max(M, x), n));
        }

        return memo[i][M] = suffix_sum[i] - min_opponent_score;
    }
};