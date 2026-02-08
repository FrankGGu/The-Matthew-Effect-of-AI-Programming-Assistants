#include <vector>
#include <numeric>

class Solution {
private:
    int calculateScore(const std::vector<int>& player) {
        int score = 0;
        int n = player.size();
        for (int i = 0; i < n; ++i) {
            int multiplier = 1;
            if ((i > 0 && player[i - 1] == 10) || (i > 1 && player[i - 2] == 10)) {
                multiplier = 2;
            }
            score += multiplier * player[i];
        }
        return score;
    }

public:
    int isWinner(std::vector<int>& player1, std::vector<int>& player2) {
        int score1 = calculateScore(player1);
        int score2 = calculateScore(player2);

        if (score1 > score2) {
            return 1;
        } else if (score2 > score1) {
            return 2;
        } else {
            return 0;
        }
    }
};