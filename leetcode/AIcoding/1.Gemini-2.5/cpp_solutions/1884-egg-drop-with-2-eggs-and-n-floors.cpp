#include <cmath>

class Solution {
public:
    int twoEggDrop(int n) {
        int moves = 0;
        while (n > 0) {
            moves++;
            n -= moves;
        }
        return moves;
    }
};