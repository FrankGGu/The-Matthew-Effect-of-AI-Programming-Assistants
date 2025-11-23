#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> numMovesStonesII(std::vector<int>& stones) {
        std::sort(stones.begin(), stones.end());

        int x1 = stones[0];
        int x2 = stones[1];
        int x3 = stones[2];

        int max_moves = (x3 - x1 - 2);

        int min_moves;
        if (x3 - x1 == 2) {
            min_moves = 0;
        } else if (x2 - x1 == 1 || x3 - x2 == 1) {
            min_moves = 1;
        } else {
            min_moves = 2;
        }

        return {min_moves, max_moves};
    }
};