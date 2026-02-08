#include <vector>
#include <cmath>

class Solution {
public:
    int furthestDistanceFromOrigin(std::string moves) {
        int x = 0, y = 0;
        for (char move : moves) {
            if (move == 'L') x--;
            else if (move == 'R') x++;
            else if (move == 'U') y++;
            else if (move == 'D') y--;
        }
        return std::abs(x) + std::abs(y) + (moves.size() - (std::abs(x) + std::abs(y))) / 2;
    }
};