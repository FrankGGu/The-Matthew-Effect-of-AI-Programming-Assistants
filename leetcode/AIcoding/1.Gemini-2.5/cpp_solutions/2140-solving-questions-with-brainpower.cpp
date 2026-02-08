#include <vector>
#include <algorithm> // For std::max and std::min

class Solution {
public:
    long long mostPoints(std::vector<std::vector<int>>& questions) {
        int n = questions.size();
        std::vector<long long> dp(n + 1, 0);

        for (int i = n - 1; i >= 0; --i) {
            long long current_points = questions[i][0];
            int brainpower_skip = questions[i][1];

            // Option 1: Solve the current question
            // Points from current question + max points from the next available question
            long long solve_option_points = current_points;
            int next_question_index = i + 1 + brainpower_skip;

            // If next_question_index is within bounds (less than n), add dp[next_question_index]
            // Otherwise, it means we've skipped beyond the last question, so 0 points from there.
            // This can be elegantly handled by using std::min(next_question_index, n)
            // because dp[n] is initialized to 0.
            solve_option_points += dp[std::min(next_question_index, n)];

            // Option 2: Skip the current question
            // Max points from the next question
            long long skip_option_points = dp[i + 1];

            // Take the maximum of the two options
            dp[i] = std::max(solve_option_points, skip_option_points);
        }

        return dp[0];
    }
};