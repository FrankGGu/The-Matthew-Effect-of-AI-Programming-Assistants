#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int furthestDistanceFromOrigin(int x, int y, string moves) {
        int countL = 0;
        int countR = 0;
        int countU = 0;
        int countD = 0;

        for (char move : moves) {
            if (move == 'L') countL++;
            else if (move == 'R') countR++;
            else if (move == 'U') countU++;
            else if (move == 'D') countD++;
        }

        int maxDistance = 0;
        int totalMoves = countL + countR + countU + countD;

        if (countL + countR > 0) {
            maxDistance += abs(x + (countR - countL));
        } else {
            maxDistance += abs(x);
        }

        if (countU + countD > 0) {
            maxDistance += abs(y + (countU - countD));
        } else {
            maxDistance += abs(y);
        }

        return maxDistance;
    }
};