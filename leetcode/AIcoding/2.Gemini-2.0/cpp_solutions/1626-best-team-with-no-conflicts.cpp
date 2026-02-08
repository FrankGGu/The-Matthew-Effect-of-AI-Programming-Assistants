#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int bestTeamScore(vector<int>& scores, vector<int>& ages) {
        int n = scores.size();
        vector<pair<int, int>> players(n);
        for (int i = 0; i < n; ++i) {
            players[i] = {ages[i], scores[i]};
        }
        sort(players.begin(), players.end());

        vector<int> dp(n, 0);
        int max_score = 0;

        for (int i = 0; i < n; ++i) {
            dp[i] = players[i].second;
            for (int j = 0; j < i; ++j) {
                if (players[j].second <= players[i].second) {
                    dp[i] = max(dp[i], dp[j] + players[i].second);
                }
            }
            max_score = max(max_score, dp[i]);
        }

        return max_score;
    }
};