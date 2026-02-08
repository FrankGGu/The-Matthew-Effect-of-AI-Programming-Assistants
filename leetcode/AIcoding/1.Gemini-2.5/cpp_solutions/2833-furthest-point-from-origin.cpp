#include <string>
#include <cmath>
#include <numeric>

class Solution {
public:
    int furthestDistanceFromOrigin(std::string moves) {
        int position = 0;
        int blanks = 0;
        for (char move : moves) {
            if (move == 'L') {
                position--;
            } else if (move == 'R') {
                position++;
            } else {
                blanks++;
            }
        }
        return std::abs(position) + blanks;
    }
};