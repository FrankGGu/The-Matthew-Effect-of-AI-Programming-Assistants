#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> numMovesMakeEqualToTarget(int a, int b, int c) {
        vector<int> stones = {a, b, c};
        sort(stones.begin(), stones.end());
        int x = stones[0], y = stones[1], z = stones[2];

        if (z - x == 2) {
            return {0, 0};
        }

        int minMoves = 0;
        if (y - x > 1) {
            minMoves += y - x - 1;
        }
        if (z - y > 1) {
            minMoves += z - y - 1;
        }

        int maxMoves = (z - x - 2);

        return {minMoves, maxMoves};
    }
};