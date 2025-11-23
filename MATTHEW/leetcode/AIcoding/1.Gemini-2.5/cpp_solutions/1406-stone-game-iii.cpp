#include <vector>
#include <string>
#include <algorithm> // For std::max

class Solution {
public:
    std::string stoneGameIII(std::vector<int>& stoneValue) {
        int n = stoneValue.size();
        // dp[i] represents the maximum score difference Alice can achieve
        // (Alice's score - Bob's score) starting from index i.
        // The size is n + 3 to handle accesses like i+1, i+2, i+3
        // without going out of bounds for the dp array, where dp[n], dp[n+1], dp[n+2]
        // will effectively be base cases (0 score difference if no stones left).
        std::vector<int> dp(n + 3, 0);

        // Iterate backwards from the last stone
        for (int i = n - 1; i >= 0; --i) {
            // Alice has three choices: take 1, 2, or 3 stones.
            // For each choice, she gets the sum of stones taken,
            // and then it's Bob's turn. Bob will play optimally to maximize his score,
            // which means minimizing Alice's score.
            // So, if Bob starts from index i+k, the score difference from that subgame
            // will be dp[i+k] (Alice's score - Bob's score).
            // Since it's Bob's turn, he will achieve a score difference of -dp[i+k]
            // from Alice's perspective.

            // Option 1: Alice takes 1 stone (stoneValue[i])
            // Her score: stoneValue[i]
            // Bob's turn starts from i+1. The resulting score difference from Bob's optimal play will be dp[i+1].
            // Alice's total score difference = stoneValue[i] - dp[i+1]
            int score1 = stoneValue[i] - dp[i + 1];

            // Option 2: Alice takes 2 stones (stoneValue[i] + stoneValue[i+1])
            // This option is only possible if there are at least 2 stones remaining (i+1 < n).
            // If not possible, initialize with a very small number to ensure it's not chosen.
            int score2 = -2e9; // A sufficiently small number, less than any possible sum
            if (i + 1 < n) {
                score2 = stoneValue[i] + stoneValue[i + 1] - dp[i + 2];
            }

            // Option 3: Alice takes 3 stones (stoneValue[i] + stoneValue[i+1] + stoneValue[i+2])
            // This option is only possible if there are at least 3 stones remaining (i+2 < n).
            // If not possible, initialize with a very small number.
            int score3 = -2e9;
            if (i + 2 < n) {
                score3 = stoneValue[i] + stoneValue[i + 1] + stoneValue[i + 2] - dp[i + 3];
            }

            // Alice chooses the option that maximizes her score difference.
            dp[i] = std::max({score1, score2, score3});
        }

        // After filling the DP table, dp[0] contains the final score difference
        // if Alice plays optimally from the beginning.
        if (dp[0] > 0) {
            return "Alice";
        } else if (dp[0] < 0) {
            return "Bob";
        } else {
            return "Tie";
        }
    }
};