#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int stoneGameVII(std::vector<int>& stones) {
        int n = stones.size();

        std::vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        std::vector<std::vector<int>> dp(n, std::vector<int>(n, 0));

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;

                // Option 1: Alice removes stones[i]
                // Her score for this move is the sum of remaining stones: stones[i+1...j]
                // The remaining game is stones[i+1...j], and it's Bob's turn.
                // Bob will play optimally to maximize his score difference over Alice.
                // The value dp[i+1][j] represents Bob's maximum score minus Alice's score for the subproblem stones[i+1...j].
                // So, from Alice's perspective, her score difference for the subproblem is -dp[i+1][j].
                // Alice's total score difference = (score for this move) + (Alice's score diff from subproblem)
                //                               = (sum of stones[i+1...j]) - dp[i+1][j]
                int sum_i_plus_1_to_j = prefixSum[j + 1] - prefixSum[i + 1];
                int choice1_score_diff = sum_i_plus_1_to_j - dp[i + 1][j];

                // Option 2: Alice removes stones[j]
                // Her score for this move is the sum of remaining stones: stones[i...j-1]
                // The remaining game is stones[i...j-1], and it's Bob's turn.
                // Similar logic: Alice's total score difference = (sum of stones[i...j-1]) - dp[i][j-1]
                int sum_i_to_j_minus_1 = prefixSum[j] - prefixSum[i];
                int choice2_score_diff = sum_i_to_j_minus_1 - dp[i][j - 1];

                // Alice chooses the option that maximizes her score difference
                dp[i][j] = std::max(choice1_score_diff, choice2_score_diff);
            }
        }

        return dp[0][n - 1];
    }
};