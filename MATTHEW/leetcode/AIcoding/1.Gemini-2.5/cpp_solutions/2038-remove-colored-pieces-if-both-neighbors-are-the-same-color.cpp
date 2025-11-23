#include <string>
#include <vector>

class Solution {
public:
    bool winnerOfGame(std::string colors) {
        int alice_moves = 0;
        int bob_moves = 0;
        int n = colors.length();

        if (n < 3) {
            return false;
        }

        for (int i = 1; i < n - 1; ++i) {
            if (colors[i] == 'A' && colors[i-1] == 'A' && colors[i+1] == 'A') {
                alice_moves++;
            } else if (colors[i] == 'B' && colors[i-1] == 'B' && colors[i+1] == 'B') {
                bob_moves++;
            }
        }

        return alice_moves > bob_moves;
    }
};