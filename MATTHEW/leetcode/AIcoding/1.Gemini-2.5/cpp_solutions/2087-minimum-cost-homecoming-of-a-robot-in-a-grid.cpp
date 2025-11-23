#include <vector>

class Solution {
public:
    long long minCost(std::vector<int>& startPos, std::vector<int>& homePos, std::vector<int>& rowCosts, std::vector<int>& colCosts) {
        long long totalCost = 0;

        int startR = startPos[0];
        int startC = startPos[1];
        int homeR = homePos[0];
        int homeC = homePos[1];

        if (startR < homeR) {
            for (int r = startR + 1; r <= homeR; ++r) {
                totalCost += rowCosts[r];
            }
        } else if (startR > homeR) {
            for (int r = startR - 1; r >= homeR; --r) {
                totalCost += rowCosts[r];
            }
        }

        if (startC < homeC) {
            for (int c = startC + 1; c <= homeC; ++c) {
                totalCost += colCosts[c];
            }
        } else if (startC > homeC) {
            for (int c = startC - 1; c >= homeC; --c) {
                totalCost += colCosts[c];
            }
        }

        return totalCost;
    }
};