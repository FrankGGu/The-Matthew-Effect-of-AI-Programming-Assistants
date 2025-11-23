class Solution {
public:
    int minCost(vector<int>& startPos, vector<int>& homePos, vector<int>& rowCosts, vector<int>& colCosts) {
        int cost = 0;
        int x1 = startPos[0], y1 = startPos[1];
        int x2 = homePos[0], y2 = homePos[1];

        if (x1 < x2) {
            for (int i = x1 + 1; i <= x2; ++i) {
                cost += rowCosts[i];
            }
        } else if (x1 > x2) {
            for (int i = x1 - 1; i >= x2; --i) {
                cost += rowCosts[i];
            }
        }

        if (y1 < y2) {
            for (int j = y1 + 1; j <= y2; ++j) {
                cost += colCosts[j];
            }
        } else if (y1 > y2) {
            for (int j = y1 - 1; j >= y2; --j) {
                cost += colCosts[j];
            }
        }

        return cost;
    }
};