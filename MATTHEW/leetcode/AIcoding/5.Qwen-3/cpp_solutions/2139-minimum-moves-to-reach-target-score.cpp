#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMovesToReachTarget(int target, int maxMove) {
        int moves = 0;
        while (target > 0) {
            moves += target % maxMove;
            target /= maxMove;
        }
        return moves;
    }
};