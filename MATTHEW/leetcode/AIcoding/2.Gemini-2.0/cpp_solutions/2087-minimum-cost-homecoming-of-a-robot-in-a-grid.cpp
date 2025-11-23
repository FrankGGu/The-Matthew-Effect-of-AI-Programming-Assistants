#include <vector>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& startPos, vector<int>& homePos, vector<int>& rowCosts, vector<int>& colCosts) {
        int rowStart = startPos[0];
        int colStart = startPos[1];
        int rowHome = homePos[0];
        int colHome = homePos[1];

        int rowCost = 0;
        if (rowStart < rowHome) {
            for (int i = rowStart + 1; i <= rowHome; ++i) {
                rowCost += rowCosts[i];
            }
        } else if (rowStart > rowHome) {
            for (int i = rowStart - 1; i >= rowHome; --i) {
                rowCost += rowCosts[i];
            }
        }

        int colCost = 0;
        if (colStart < colHome) {
            for (int i = colStart + 1; i <= colHome; ++i) {
                colCost += colCosts[i];
            }
        } else if (colStart > colHome) {
            for (int i = colStart - 1; i >= colHome; --i) {
                colCost += colCosts[i];
            }
        }

        return rowCost + colCost;
    }
};