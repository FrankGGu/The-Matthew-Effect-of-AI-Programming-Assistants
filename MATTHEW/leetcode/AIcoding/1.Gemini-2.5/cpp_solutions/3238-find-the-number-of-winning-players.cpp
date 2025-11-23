#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int numberOfWinningPlayers(std::vector<std::vector<int>>& players) {
        int n = players.size();

        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }

        int maxA = std::numeric_limits<int>::min();
        int maxD = std::numeric_limits<int>::min();

        for (const auto& player : players) {
            maxA = std::max(maxA, player[0]);
            maxD = std::max(maxD, player[1]);
        }

        int countMaxA = 0;
        int countMaxD = 0;
        int winningPlayerCandidateIndex = -1;

        for (int i = 0; i < n; ++i) {
            if (players[i][0] == maxA) {
                countMaxA++;
            }
            if (players[i][1] == maxD) {
                countMaxD++;
            }
            if (players[i][0] == maxA && players[i][1] == maxD) {
                winningPlayerCandidateIndex = i;
            }
        }

        if (countMaxA == 1 && countMaxD == 1 && winningPlayerCandidateIndex != -1) {
            return 1;
        } else {
            return 0;
        }
    }
};