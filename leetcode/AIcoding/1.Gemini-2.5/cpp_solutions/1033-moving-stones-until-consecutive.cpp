#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<int> numMovesStones(int a, int b, int c) {
        std::vector<int> stones = {a, b, c};
        std::sort(stones.begin(), stones.end());
        int x = stones[0];
        int y = stones[1];
        int z = stones[2];

        if (z - x == 2) {
            return {0, 0};
        }

        int min_moves;
        if (y - x <= 2 || z - y <= 2) {
            min_moves = 1;
        } else {
            min_moves = 2;
        }

        int max_moves = z - x - 2;

        return {min_moves, max_moves};
    }
};