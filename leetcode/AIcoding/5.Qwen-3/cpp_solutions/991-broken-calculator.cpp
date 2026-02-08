#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int brokenCalc(int target, int k) {
        int moves = 0;
        while (target > k) {
            if (target % 2 == 1) {
                target++;
                moves++;
            }
            target /= 2;
            moves++;
        }
        return moves + (k - target);
    }
};