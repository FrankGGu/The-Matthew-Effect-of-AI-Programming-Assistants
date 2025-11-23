#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> findWinners(vector<vector<int>>& matches) {
        map<int, int> lost_matches;
        vector<int> all_players;

        for (auto& match : matches) {
            int winner = match[0];
            int loser = match[1];

            all_players.push_back(winner);
            all_players.push_back(loser);

            lost_matches[loser]++;
        }

        vector<int> winners;
        vector<int> losers_one_match;
        sort(all_players.begin(), all_players.end());
        all_players.erase(unique(all_players.begin(), all_players.end()), all_players.end());

        for (int player : all_players) {
            if (lost_matches.find(player) == lost_matches.end()) {
                winners.push_back(player);
            } else if (lost_matches[player] == 1) {
                losers_one_match.push_back(player);
            }
        }

        vector<vector<int>> result;
        result.push_back(winners);
        result.push_back(losers_one_match);

        return result;
    }
};