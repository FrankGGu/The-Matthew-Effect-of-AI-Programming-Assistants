#include <vector>

class Solution {
public:
    int findWinningPlayer(std::vector<int>& skills, int k) {
        int current_winner_idx = 0;
        int consecutive_wins = 0;

        for (int i = 1; i < skills.size(); ++i) {
            if (skills[current_winner_idx] > skills[i]) {
                consecutive_wins++;
            } else {
                current_winner_idx = i;
                consecutive_wins = 1;
            }
            if (consecutive_wins == k) {
                return current_winner_idx;
            }
        }

        return current_winner_idx;
    }
};