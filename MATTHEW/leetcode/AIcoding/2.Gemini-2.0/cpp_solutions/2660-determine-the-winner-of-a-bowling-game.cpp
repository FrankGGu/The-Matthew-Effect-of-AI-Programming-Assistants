#include <vector>

using namespace std;

class Solution {
public:
    int isWinner(vector<int>& player1, vector<int>& player2) {
        auto calculate_score = [&](const vector<int>& player) {
            int score = 0;
            for (int i = 0; i < player.size(); ++i) {
                if (i > 0 && player[i - 1] == 10) {
                    score += 2 * player[i];
                } else if (i > 1 && player[i - 2] == 10) {
                    score += 2 * player[i];
                } else {
                    score += player[i];
                }
            }
            return score;
        };

        int score1 = calculate_score(player1);
        int score2 = calculate_score(player2);

        if (score1 > score2) {
            return 1;
        } else if (score2 > score1) {
            return 2;
        } else {
            return 0;
        }
    }
};