#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int bestTeamWinning(vector<int>& ages, vector<int>& scores) {
        vector<pair<int, int>> players;
        for (int i = 0; i < ages.size(); ++i) {
            players.push_back({ages[i], scores[i]});
        }
        sort(players.begin(), players.end());

        vector<int> dp(ages.size(), 0);
        for (int i = 0; i < ages.size(); ++i) {
            dp[i] = players[i].second;
            for (int j = 0; j < i; ++j) {
                if (players[j].second <= players[i].second) {
                    dp[i] = max(dp[i], dp[j] + players[i].second);
                }
            }
        }
        return *max_element(dp.begin(), dp.end());
    }
};