#include <vector>
#include <algorithm>
#include <utility> // For std::pair

class Solution {
public:
    long long bestTeamScore(std::vector<int>& scores, std::vector<int>& ages) {
        int n = scores.size();
        std::vector<std::pair<int, int>> players(n);
        for (int i = 0; i < n; ++i) {
            players[i] = {ages[i], scores[i]};
        }

        std::sort(players.begin(), players.end());

        std::vector<long long> dp(n);
        long long max_team_score = 0;

        for (int i = 0; i < n; ++i) {
            dp[i] = players[i].second; // Initialize with the player's own score

            // Check previous players (j < i) to potentially form a larger team
            for (int j = 0; j < i; ++j) {
                // Due to sorting, we know age[j] <= age[i].
                // The conflict condition is: "a younger player has a strictly higher score than an older player."
                // This means if age[j] < age[i], we must have score[j] <= score[i].
                // If age[j] == age[i], then score[j] <= score[i] is guaranteed by the secondary sort key
                // (sorting by score ascending for equal ages). In this case, there's no younger/older distinction,
                // and the condition score[j] <= score[i] still allows building a non-decreasing score sequence.
                if (players[j].second <= players[i].second) {
                    dp[i] = std::max(dp[i], dp[j] + players[i].second);
                }
            }
            max_team_score = std::max(max_team_score, dp[i]);
        }

        return max_team_score;
    }
};