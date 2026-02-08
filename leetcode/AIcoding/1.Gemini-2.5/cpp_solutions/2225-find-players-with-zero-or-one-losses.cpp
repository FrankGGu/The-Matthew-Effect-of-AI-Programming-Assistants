#include <vector>
#include <map>
#include <set>

class Solution {
public:
    std::vector<std::vector<int>> findWinners(std::vector<std::vector<int>>& matches) {
        std::map<int, int> loss_counts;
        std::set<int> all_players;

        for (const auto& match : matches) {
            int winner = match[0];
            int loser = match[1];
            loss_counts[loser]++;
            all_players.insert(winner);
            all_players.insert(loser);
        }

        std::vector<std::vector<int>> result(2);

        for (int player_id : all_players) {
            if (loss_counts.find(player_id) == loss_counts.end()) {
                result[0].push_back(player_id);
            } else if (loss_counts[player_id] == 1) {
                result[1].push_back(player_id);
            }
        }

        return result;
    }
};