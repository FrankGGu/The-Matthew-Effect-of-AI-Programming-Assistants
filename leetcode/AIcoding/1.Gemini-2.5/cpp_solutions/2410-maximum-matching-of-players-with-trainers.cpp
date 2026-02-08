#include <vector>
#include <algorithm>

class Solution {
public:
    int matchPlayersAndTrainers(std::vector<int>& players, std::vector<int>& trainers) {
        std::sort(players.begin(), players.end());
        std::sort(trainers.begin(), trainers.end());

        int player_idx = 0;
        int trainer_idx = 0;
        int matches = 0;

        while (player_idx < players.size() && trainer_idx < trainers.size()) {
            if (players[player_idx] <= trainers[trainer_idx]) {
                matches++;
                player_idx++;
                trainer_idx++;
            } else {
                trainer_idx++;
            }
        }

        return matches;
    }
};